//
//  CwlCatchException.swift
//  CwlAssertionTesting
//
//  Created by Matt Gallagher on 2016/01/10.
//  Copyright © 2016 Matt Gallagher ( http://cocoawithlove.com ). All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
//  SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
//

import Foundation

#if false
	// We can't simply cast to Self? in the catchInBlock method so we need this generic function wrapper to do the conversion for us. Mildly annoying.
	private func catchReturnTypeConverter<T: NSException>(_ type: T.Type, block: () -> Void) -> T? {
		return catchExceptionOfKind(type, block) as? T
	}

	extension NSException {
		public static func catchException(in block: () -> Void) -> Self? {
			return catchReturnTypeConverter(self, block: block)
		}
	}
#else
	// As of Nov 2016, the Swift development snapshots don't seem to like the previous version.
	// You can use this version if you prefer.
	private func catchReturnTypeConverter<T: NSException>(_ instance: T, block: () -> Void) -> T? {
		// Get the type from an *instance*, instead of a receiving the type directly
		return catchExceptionOfKind(T.self, block) as? T
	}

	extension NSException {
		public static func catchException(in block: () -> Void) -> Self? {
			// Use a dummy instance of Self to provide the type
			return catchReturnTypeConverter(self.init(), block: block)
		}
	}
#endif

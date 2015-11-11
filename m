From: ARaybould <araybould@skymion.com>
Subject: Apple Xcode Asserts Control Over Git - License Violation?
Date: Wed, 11 Nov 2015 09:30:04 -0500
Message-ID: <B28E3F82-E5BD-4B6A-A28D-CEA54774E8D9@skymion.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 15:38:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwWWZ-0008G6-6h
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 15:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbbKKOhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2015 09:37:15 -0500
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:53885
	"EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251AbbKKOhO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 09:37:14 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2015 09:37:14 EST
Received: from [192.168.1.104] ([47.17.188.230])
	by p3plsmtpa07-04.prod.phx3.secureserver.net with 
	id gEW41r0094yhhLn01EW5cj; Wed, 11 Nov 2015 07:30:05 -0700
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281164>

I recently installed Xcode 7.1.1 on my Mac. While this was underway, I =
continued to work on an unrelated project, until I found I could not us=
e git from the command-line. Instead, I got this message:

Agreeing to the Xcode/iOS license requires admin privileges, please re-=
run as root via sudo.

Is Apple in violation of git=E2=80=99s license by imposing this restric=
tion?

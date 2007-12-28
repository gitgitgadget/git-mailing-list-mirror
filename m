From: Thien-Thi Nguyen <ttn@gnuvola.org>
Subject: reflog weirdness
Date: Fri, 28 Dec 2007 20:57:21 +0100
Message-ID: <87ve6iegny.fsf@ambire.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 21:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8LZh-0005tR-PH
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 21:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXL1UM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 15:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbXL1UM3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 15:12:29 -0500
Received: from ppp-88-39.21-151.libero.it ([151.21.39.88]:44345 "EHLO
	ambire.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751903AbXL1UM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 15:12:28 -0500
X-Greylist: delayed 807 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2007 15:12:28 EST
Received: from ttn by ambire.localdomain with local (Exim 4.63)
	(envelope-from <ttn@gnuvola.org>)
	id 1J8LKb-0004gD-HB
	for git@vger.kernel.org; Fri, 28 Dec 2007 20:57:21 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69295>

--=-=-=

hello,

i use git-1.5.3.5 and see the following fragment from "git reflog"
(not inline due to binary values):


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=foo
Content-Transfer-Encoding: base64
Content-Description: fragment of \"git reflog\" output

ODJjNmQ4Zi4uLiBIRUFEQHsxOX06IGNvbW1pdDogUmVkdWNlIGRlcGVuZGVuY3kgb24gYGVsaXAt
ZGF0YWRpcicuCjU5ZTJkYzcuLi4gSEVBREB7MjB9OiByZXNldCBIRUFEXgoyMGQ5ZDIzLi4uIEhF
QURAezIxfTogY29tbWl0OiAfiwiByo5xRwNdjjsOgcIwEER7n2I6PgKB01OB04HQUHACFnuCLIHs
gd2ByHGKgdweJyWB3UiB84HmgfNknAMROVIjNSwwgcWLOY2B5yhNYoGqO4HvgdwRk4HNNYHwgbIa
nhmB+40ogfKB5YaBvWWB4oHhiochm35YEWxcgbCBwUNpgd6B3XVqlHhCgaiURgxWizQMKXddga0g
aU6B2m+B9C6B/4G3gdYLga6BuDFzgc2B9YB3PzA3lhGBtAo1OWUyZGM3Li4uIEhFQURAezIyfTog
Y29tbWl0OiAoZWxpcC1oZWxwKTogVXNlIGBwb3AtdG8tYnVmZmVyJy4K
--=-=-=


i'd like to get rid of (or somehow get git to hide) the {21} line.
any hints?

thi

--=-=-=--

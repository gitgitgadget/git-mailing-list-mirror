From: Thien-Thi Nguyen <ttn@gnuvola.org>
Subject: git-cherries
Date: Mon, 27 Feb 2012 11:56:19 +0100
Message-ID: <874nucee98.fsf@gnuvola.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 12:02:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1yM2-0003g9-3j
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 12:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab2B0LCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 06:02:48 -0500
Received: from smtp206.alice.it ([82.57.200.102]:56277 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab2B0LCs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 06:02:48 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Feb 2012 06:02:47 EST
Received: from ambire (79.51.73.35) by smtp206.alice.it (8.6.023.02)
        id 4F1836AD04D7A65F for git@vger.kernel.org; Mon, 27 Feb 2012 11:57:13 +0100
Received: from ttn by ambire with local (Exim 4.72)
	(envelope-from <ttn@gnuvola.org>)
	id 1S1yFf-0001yK-Gz
	for git@vger.kernel.org; Mon, 27 Feb 2012 11:56:19 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191620>

--=-=-=
Content-Type: text/plain

For my personal use, i wrote git-cherries, attached.
It commits each hunk of every modified file separately
(creating cherries to cherry-pick later, you see).

I am writing to ask if this is already in Git somewhere,
and if not, for tips on how to make it faster / more elegant.

Please cc me in replies, as i am not subscribed.

Thanks!

_____________________________________________

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=git-cherries
Content-Transfer-Encoding: base64

IyEvYmluL3NoCmJsdXJiPSIkezEtY2hlcnJ5fSIKZ2l0IHN0YXR1cyAtLXNob3J0IFwKICAgIHwg
c2VkICcvXiBNIC8hZDtzLy8vJyBcCiAgICB8IHdoaWxlIHJlYWQgZmlsZW5hbWUKZG8KICAgIHBy
aW50ZiAnXG5wcm9jZXNzaW5nOiAlc1xuJyAkZmlsZW5hbWUKICAgIG49MAogICAgd2hpbGUgWyAi
JChnaXQgc3RhdHVzIC0tc2hvcnQgLS0gJGZpbGVuYW1lKSIgXQogICAgZG8KICAgICAgICBuPSQo
ZXhwciAxICsgJG4pCiAgICAgICAgcHJpbnRmICd5XG5xXG4nIHwgZ2l0IGFkZCAtLXBhdGNoICRm
aWxlbmFtZSA+L2Rldi9udWxsCiAgICAgICAgcHJpbnRmICclNWQgLS0gJyAkbgogICAgICAgIGdp
dCBjb21taXQgLW0iJG4gJGZpbGVuYW1lICgkYmx1cmIpIiBcCiAgICAgICAgICAgIHwgc2VkICcx
ZDtzLy4qIGNoYW5nZWQsIC8vO3MvW14wLTksXS8vZztzLywvJiAvJwogICAgZG9uZQpkb25lCg==
--=-=-=--

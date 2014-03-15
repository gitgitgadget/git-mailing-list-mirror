From: shyam218 <krishnah014@gmail.com>
Subject: Migration from Github hosted git repository to local server.
Date: Sat, 15 Mar 2014 11:58:13 -0700 (PDT)
Message-ID: <1394909893698-7605713.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 19:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOtmk-0003Xl-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 19:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbaCOS6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 14:58:14 -0400
Received: from sam.nabble.com ([216.139.236.26]:50172 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755951AbaCOS6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 14:58:14 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <krishnah014@gmail.com>)
	id 1WOtmf-0006wR-Ms
	for git@vger.kernel.org; Sat, 15 Mar 2014 11:58:13 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244163>

Hi All,

Could some one help me on this please,we have few repositories in the Github
and out of them couple of them are using encryption with
git-encrypt(https://github.com/shadowhand/git-encrypt)using this they have
encrypted the whole repo.

Now,we got a requirement to move all those repositories to In house
server,just for preserving the source code from hosting in third party tool.

Anybody help me in migrating them with out loosing any history and i really
appreciate if some one can give a detailed steps on how to decrypt the
encrypted file(procedure mentioned in the git-encrypt wasn't helpful
(https://github.com/shadowhand/git-encrypt) and the link for decryption
mentioned in it is also not working)

Regards,
Shyam.



--
View this message in context: http://git.661346.n2.nabble.com/Migration-from-Github-hosted-git-repository-to-local-server-tp7605713.html
Sent from the git mailing list archive at Nabble.com.

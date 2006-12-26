From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Adding spell checker to GIT
Date: Tue, 26 Dec 2006 17:32:14 +0530
Message-ID: <b5a19cd20612260402l36451df3g6759de238e05c67c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_76919_17715127.1167134534592"
X-From: git-owner@vger.kernel.org Tue Dec 26 13:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzB0q-00055r-Nb
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 13:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWLZMCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 07:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWLZMCR
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 07:02:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:39330 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531AbWLZMCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 07:02:16 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4809352nfa
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 04:02:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=VtGVPsTaP+IoIVKasdfrfnMJ62ot7fhoJwlWODe4A9qPekbMQ4LlizkDsjcf6SofsO61v2j4mbyvbJww3CqV10MuTwkrjr9XJuAkFg6WjhvI+Kbsv1fOTPJbQIdi1Kl9DwhS4D6vypxF+RkjF2emjaIfXL+GErlbeS4UTFohfsM=
Received: by 10.48.48.18 with SMTP id v18mr15835499nfv.1167134535563;
        Tue, 26 Dec 2006 04:02:15 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Tue, 26 Dec 2006 04:02:14 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35417>

------=_Part_76919_17715127.1167134534592
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
        I just need some more help on how to check the file in
concerned in the pre commit hook , i have attached a document which
containes the basic perl code i am going to use.

Regards
Deepak

-- 
Code Code Code Away

------=_Part_76919_17715127.1167134534592
Content-Type: application/octet-stream; name="test"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test"
X-Attachment-Id: f_ew69rawx

IyEvdXNyL2Jpbi9wZXJsIC13CiNTcGVsbCBjaGVja2luZyBzY3JpcHQgaW4gcGVybCBmb3IgR0lU
IHNvdXJjZSB0cmFja2VyIHByb2dyYW0uCiNTaG91bGQgYmUgcGFydCBvZiBwcmUtY29tbWl0IGhv
b2sKCiAgICB1c2UgVGV4dDo6QXNwZWxsOwogICAgbXkgJGZpbGVuYW1lOwogICAgbXkgJGNvbnRp
bnVlID0gMDsgCiAgICBvcGVuKCRmaWxlbmFtZSwiLi9jaGVja2VyLnNoIikgb3IgZGllICJDb3Vs
ZCBub3Qgb3BlbiBmaWxlIjsKICAgIG15ICRzcGVsbGVyID0gVGV4dDo6QXNwZWxsLT5uZXc7CiAg
ICBkaWUgdW5sZXNzICRzcGVsbGVyOwogICAgd2hpbGUoPCRmaWxlbmFtZT4pIHsKCQoJaWYobS9c
L1wqLyB8fCAkY29udGludWUgPT0gMSkgewoJICAgQHdvcmRzID0gc3BsaXQgLyAvLCRfOwogICAg
ICAgICAgIGZvcmVhY2ggJHdvcmQgKEB3b3JkcykgewogICAgICAgICAgIGlmKCR3b3JkIGVxICIq
LyIpIHsKICAgICAgICAgICAgICAgICRjb250aW51ZSA9IDA7CgkgICAJbGFzdDsKCSAgIH0KCSAg
IGVsc2UgewoJICAgCXByaW50ICRzcGVsbGVyLT5jaGVjaygkd29yZCkKCQkgCT8gIiR3b3JkIGZv
dW5kXG4iCiAgICAgICAgICAgICAgICAgCTogIiR3b3JkIG5vdCBmb3V1bmQgXG4iOwogICAgICAg
ICAgIAl9CgkgICAkY29udGludWUgPSAxOwoJICAgfQoJCgl9CiAgICAgbmV4dDsJCiAgICB9CiAg
ICBjbG9zZSAkZmlsZW5hbWU7CgoK
------=_Part_76919_17715127.1167134534592--

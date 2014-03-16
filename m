From: Quint Guvernator <quintus.public@gmail.com>
Subject: [GSoC 2014] Refactoring git rebase --interactive
Date: Sun, 16 Mar 2014 16:13:52 -0400
Message-ID: <CALs4jVE16V41z6X7dg-kyYeRi0b=mZZ=iSN_sOUmcZREezN_ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 21:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPHRr-0006Jx-2K
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 21:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbaCPUOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 16:14:14 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41271 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbaCPUON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 16:14:13 -0400
Received: by mail-wi0-f180.google.com with SMTP id hn9so1366168wib.1
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=f6D9x91nn8iUJxVlVkuYwt9Sb0YK5AtrRg6pTQ2PH0g=;
        b=Sa+K6kOslMb9oQ3RrvFzoBVyW3Vf5nkGs9Ou8jIGUwNg0tApCOygk+SHpD2tSEsiEK
         LQRhOu4jOU4aNq2oD7ats+mvAdXcaata1finJDiCruAFgQCNuwXVM8kPqT1BDckL3xD1
         7oIt+G1Z6np8BtJUH9Q4tqdttz7DkYNnm/M7yGvDCOTGtC8RsqRaGe0T2qdJb6JjBUuH
         W9jVJVSSTIsG3l3UoGncLUysJNm7eFx0MZXN6gl6JbSFXySizbzpl+DmF5MpOH5tHMDd
         52H1b1hX+cl1qXaKRowFr04c6OAzTfmZf4ktxn2pwsxfVaFnHPs2A7BD8Ak8gTD3Lnk4
         On0w==
X-Received: by 10.180.100.169 with SMTP id ez9mr6761387wib.15.1395000852043;
 Sun, 16 Mar 2014 13:14:12 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Sun, 16 Mar 2014 13:13:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244208>

Hi again, Git community!

My name is Quint Guvernator, and I am participating in the Google
Summer of Code program. I am in university at the College of William
and Mary in Williamsburg, VA and plan to major in Computer Science and
Linguistics.

I have been working on a microproject [1][2] to get the hang of
submitting patches and working with the mailing list.

I have just submitted my proposal for git rebase --interactive through
the google-melange website. In brief, I plan to refactor the shell
script, cleaning up parts where the code is incohesive or difficult to
decipher; add functionality to the script; and improve documentation
by describing the script in comments and improving our user docs. I
think it is important not to rush into new features, however, and
detail in my proposal the extent to which I will stay in contact with
the community through this list and on IRC.

Should the work on rebase --interactive not take all summer, I would
work to improve the quality of Git documentation. I am a native
English speaker and copy-edit a local newspaper, so I feel I am
qualified to edit and extend the Git documentation.

I am happy to receive private mail, so please send any issues or
questions you may have either to the list or directly to my inbox.

Thanks for your consideration for GSoC.

--Quint

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243940
[2]: http://thread.gmane.org/gmane.comp.version-control.git/244159

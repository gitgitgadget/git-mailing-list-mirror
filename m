From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFH] Questions for Git User's Survey 2009
Date: Fri, 29 May 2009 18:55:01 +0200
Message-ID: <200905291855.03328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 18:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA5MZ-0001en-Ne
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 18:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbZE2QzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbZE2QzL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 12:55:11 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:58728 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbZE2QzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 12:55:10 -0400
Received: by bwz22 with SMTP id 22so6255753bwz.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=AUQcI7d+zECpzvGyR6bMUhaLHMHz95Yw3UI/GZJphfM=;
        b=t7djNyZIXoEgkbxh2VB5hZCxxkZeJ2oEsdQEajWWdbEzOZKLohIARVybM+AocCHwiA
         hZHViHNa0kWz4b+6LWp/L/OGf+mv2Jn8JwCmnlkKbJOkYCStOyUCwOJeoxIl/dV5ESIV
         Vn10eH/mn6+0uYLmkLQCTp/U5GCHyD6MD3Mq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=qWo3pcX6u/gJB/zB/ryOuTGvQZHwPxEXKslqpX/b5vVfue2nMrdjwRUoIVE/Qs0mx8
         STKLNK+WHR84AKucvVsw2dRP7usMtpVeaH9FanQEQNJkQulQqiVNfiQrnNA66qGT1sVA
         TQzzMUd6ya5offuPOnNdiYjv+3LipoAtjcI4o=
Received: by 10.204.59.14 with SMTP id j14mr2601062bkh.39.1243616110731;
        Fri, 29 May 2009 09:55:10 -0700 (PDT)
Received: from ?192.168.1.13? (abwe32.neoplus.adsl.tpnet.pl [83.8.228.32])
        by mx.google.com with ESMTPS id p9sm2763674fkb.7.2009.05.29.09.55.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 09:55:10 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120287>

Even though analyzing answers from "Git User's Survey 2008" is not=20
finished (although I have added partial results for questions with a=20
free-form part, see http://git.or.cz/gitwiki/GitSurvey2008), it looks=20
like there is time for annual Git User's Survey (which takes place in=20
summer)... or at least thinking about possible questions.  Coming up
with a good list of questions (see below) would take time.

More than 55% of people answering survey wanted to have Git User's=20
Survey repeated, with below 1% of people who didn't want for there
to be next year survey.

On the other hand one of common complaints was that the survey was
much too long, with around 60 questions (one question was split into
two). It was requested for survey in this year to have maximum 20
questions.


So what I would like to have is to come up with a LIST OF QUESTIONS
and possible answers; I'd like to limit number of questions with=20
free-form part, and reduce number of free-form questions to absolute
minimum; they are pain to analyse with so large number of responses.

Please write also _why_ you would want a question; what we can learn
from it, how it can help in developing git.

Thanks in advance

--=20
Jakub Nar=C4=99bski
Poland

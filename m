From: "A.J. Rossini" <blindglobe@gmail.com>
Subject: Re: On Sponsor Notices
Date: Fri, 26 Sep 2008 15:31:25 +0200
Message-ID: <1abe3fa90809260631h59bcdf52t55a2e4e50f190ebe@mail.gmail.com>
References: <20080924204358.144077183@suse.cz>
	 <20080924225120.GL10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 26 15:32:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjDQy-00050z-8D
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 15:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbYIZNb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 09:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYIZNb1
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 09:31:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:28270 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbYIZNb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 09:31:26 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1109403wfd.4
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NgjBr29Ep2bjmQLwtRhvMtmZwtYZs6KCt+uuJF8anCM=;
        b=xqLbbT68QmKlFzZjFT6xJnYNmYPdtuMERf3Ro7IhEcLLneVTnLS/mhxKYzb5Ng+NrE
         rGIgVMDpYywZ0g6L1krqRE0QH/nOBe6EkSWvubfI6Gi+8TsAP78L+aO1gZIRRjzmGsob
         O77VD7TEpw5LSdSPOrn370tTVdV/qwDGddwiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mGaOfivx3mGENyCHKwYkvaeP8HxgOb3fxFuCk4j6ys57/8VobSeIrLjjyL4xD8kg1L
         MQnK+o3JZpGyQ4W9xACsJ1r48gIgwBNcu4ucntOV0ODVE/RdRSDAtG4BfI32HdwwOtAW
         w4p5FJSTOQXco2ovpw/G+TiLjA9+eK43IQcO8=
Received: by 10.143.42.6 with SMTP id u6mr578273wfj.140.1222435885664;
        Fri, 26 Sep 2008 06:31:25 -0700 (PDT)
Received: by 10.142.229.20 with HTTP; Fri, 26 Sep 2008 06:31:25 -0700 (PDT)
In-Reply-To: <20080924225120.GL10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96850>

Petr -

I should have been clear!   What I meant to say was that it would be
nice to have things like our Novartis sponsorship in the README of
projects which are particular to the repository structure and client
which we (well, you :-), developed, and make them available, but I'd
not be certain I'd like to have such acknowledgement entered into the
git development proper (I'd prefer to think that the changes would
have been made anyway, we just accelerated them -- however for the
direct project code (non-general), that clearly should have in a
README (not license) sponsored by Novartis, as it's technically
pre-competitive (we'd love to hire people who in addition to quant and
science skills, know how to use it for statistical/mathematical
modeling, and/or improve it).

(BTW, if anyone is interested in the possibility of a similar summer
project in Basel, working for a certain large multinational Pharma
company, doing open source work, possibly around git or other
"information management projects", please let me know -- we can take
on undergrads and grad students who know programming, mathematics, and
statistics, or just one of those disciplines -- it's not too bad, just
ask Petr).


On Thu, Sep 25, 2008 at 12:51 AM, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
>  to follow up a little on the "This patch has been sponsored by
> Novartis" messages - I have been on a summer internship at Novartis busy
> deploying Git and these patches (still quite a few more to come, mostly
> for gitweb) have been one of the main outputs of that work.
>
>  However, I'm not sure if acknowledging the Novartis-originated patches
> in the log message like this is the best practice and we will understand
> if the maintainers will decide to strip these notices when applying the
> patches. Usually, this kind of acknowledgement is made by using
> "sponsored" email addresses, however mine will probably stop working
> shortly after I leave and the only way to read it is, shall we say,
> utmostly inconvenient. ;-) Now, Shawn has proposed 'Sponsored-by:' line
> at the header footer, which is also an interesting possibility.
>
> --
>                                Petr "Pasky" Baudis
> People who take cold baths never have rheumatism, but they have
> cold baths.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
best,
-tony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we
can easily roll-back your mistakes" (AJR, 4Jan05).

Drink Coffee:  Do stupid things faster with more energy!

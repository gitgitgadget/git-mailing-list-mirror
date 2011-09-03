From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sat, 3 Sep 2011 17:38:11 +0200
Message-ID: <201109031738.11678.jnareb@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <CAMP44s0N6pCUe_nop66yTwWitP6LhJXsnaVNwYH46OaxRbdVKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 17:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzsIs-0003Iq-Kf
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 17:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab1ICPiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 11:38:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60335 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab1ICPiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 11:38:16 -0400
Received: by fxh19 with SMTP id 19so2540184fxh.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2tZnMZ2yIHj034FdQHpF5dFt04FMXRC0RMgQjn/YtME=;
        b=Oe+pb75sT0o3uezL4qVOg5rC6Oyk3y5tkvAzrFRzKnBr7HAgeBvUsJvYjISOHdjEag
         YCEuHYCglrnTxAQcnRhX5HmNfukIl26otDWcGABdMVxo5N71A6epSLG9wELYZfpuc+Ga
         xVwK27XSPY6QkciKa8g3OIychZCcBR0vlTjWk=
Received: by 10.223.74.89 with SMTP id t25mr1854344faj.65.1315064294590;
        Sat, 03 Sep 2011 08:38:14 -0700 (PDT)
Received: from [192.168.1.13] (abwo246.neoplus.adsl.tpnet.pl [83.8.238.246])
        by mx.google.com with ESMTPS id e4sm1421729fag.25.2011.09.03.08.38.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 08:38:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAMP44s0N6pCUe_nop66yTwWitP6LhJXsnaVNwYH46OaxRbdVKg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180657>

On Sat, 3 Sep 2011, Felipe Contreras wrote:
> 2011/7/25 Jakub Narebski <jnareb@gmail.com>:

> > I am planning doing annual Git User's Survey, and I'd like to ask for
> > feedback.
> 
> Do you have an updated version somewhere?

You can preview test version of survey at

  https://www.survs.com/survey/VEBXFGJ9B0

Note that all answers in this test channel will be deleted!

Up to date version was sent to git mailing list as

  [RFCv2] Questions for "Git User's Survey 2011"
  http://article.gmane.org/gmane.comp.version-control.git/180643

and can be found on Git Wiki:

  http://git.wiki.kernel.org/index.php/GitSurvey2011


P.S. If I remember correctly you wanted some question about "staging area"
terminology, or something like that.  Do you have concrete proposal for
question and list of answers?

I was thinking about

  xx. How do you include changes in new commit?
  (multiple choice, with other)

  [ ] commit -a
  [ ] commit <file>
  [ ] commit -i <file>
  [ ] git add
  [ ] git stage
  [ ] git update-index
  [ ] incremental add / commit
  [ ] other, please specify __________________________

(it is not in current version of survey, but can be added before it starts
for real)... though it is only small subset of "stage" vs "the index"
terminology.  If you have something better...

-- 
Jakub Narebski
Poland

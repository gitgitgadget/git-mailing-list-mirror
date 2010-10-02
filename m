From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Advertising the Git User's Survey 2011
Date: Sat, 2 Oct 2010 11:50:59 +0530
Message-ID: <20101002062056.GB16626@kytes>
References: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 08:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1vU4-0004Tk-JR
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 08:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0JBGWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Oct 2010 02:22:06 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48572 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0JBGWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 02:22:04 -0400
Received: by pxi10 with SMTP id 10so931428pxi.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tEJao2Xlz7FpdQR81pTUMg8LR1egDaY5XXpHtc/hezM=;
        b=ibuOjGH4g8aZ0DsGDjztVklbVm8XKnSR+2uWgn2waogyDJS0/LlmqC8utmbzwvHNwT
         Y43g6veAu5SlRTjaVzrGMF1K1N/aSEkliWoL+R69h0PkNRgwxLl7LoqtfTzQkDpXaX9H
         2u6dJKS7DhVgzjefgUn8e0+DwqYfeYbTFJSzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EBztQnqghJW28/c9fGslBg6GZB5oiB9yNcFQemOIcbNnia4SLcYKfOvCGmBMRQ0C70
         EHxDLno5ot7IfF/eome1bWgF9VjGax3K27XkH1AlhcuruQ88yGFXlkUwjdWrDwe4B1oD
         pB/RBi0rYyHhKR+D+FHJFPTRCiJaRtaqk08RY=
Received: by 10.114.24.15 with SMTP id 15mr7695895wax.122.1286000524066;
        Fri, 01 Oct 2010 23:22:04 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm3414996wam.7.2010.10.01.23.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 23:22:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157793>

Hi Jakub and =C6var,

=C6var Arnfj=F6r=F0 Bjarmason writes:
> On Mon, Sep 20, 2010 at 13:38, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>=20
> > Currenly the survey has more than 5000 responses (in a not whole mo=
nth)
>=20
> That seems somewhat low, but maybe people just aren't that interested
> in taking surveys.

Nice work on the survey! This is our best year by far. Some general
observations:

Interesting statistic: 24508 people viewed it, 7821 people completed
it, but 0 people started filling out information and later decided not
to submit it. It could mean that many people clicked through and found
the survey, but probably left because it looked too long at a glance?
The average time spent on the survery is 34 minutes
- I think we can bring that down to 10~15 minutes if we design
questions to extract more information. Also, there's little incentive
for taking the survey: while many companies actually give out
discounts/ coupons for taking surveys, the least we can do is present
real-time results in the most interesting manner possible ie. survey
takers should see the "results so far" immediately after taking the
survey; some visualizations such as pie charts?

In questions 5, 10, 12, 13, 16, cut down out the options that have
very few respondents and let them all go into "other". It probably
doesn't actually save the survey taker any time, but I think seeing a
long page with many options can be scary.

1. Country of residence: we can probably make this a nice click-on-map
   interface as opposed to freeform text. It'll be more useful to us,
   and more interesting to users when we advertise the results.
2. Age: Maybe we restrict the input to 2-digit integers and draw a
   graph with all these integers to show a mean, median etc?
11. Just change this to an optional sometimes/ often? Why should users
    spend time clicking on "never"?
17, 18: Merge perhaps?
24, 25: Merge into single question with options: "Yes, and my problems
        are solved more often than not", "Yes, but my problems often
        remain unresolved", "No, I don't go to others for help".
26, 27: Merge into "How do you talk to other people using Git, either
        for technical help or otherwise?"

Ofcourse, I understand that there must be some technical constraints
due to which some things are not implementable (eg. survs doesn't
provide the feature?), but I've not taken that into consideration.

-- Ram

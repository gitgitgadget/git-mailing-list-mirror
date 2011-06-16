From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Thu, 16 Jun 2011 16:15:04 +0200
Message-ID: <201106161615.04870.jnareb@gmail.com>
References: <4DF87B42.1020004@st.com> <4DF8A896.7080708@op5.se> <4DF97998.7070604@st.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 16:15:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXDLx-0001QI-5J
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 16:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135Ab1FPOPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 10:15:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52144 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758106Ab1FPOPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 10:15:14 -0400
Received: by fxm17 with SMTP id 17so1136547fxm.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=XtaQLcQ9SidTMPgafY0ptOuhaG4UZo9J+v4v6q93CRo=;
        b=vpj1psmmEtiU/x5+X8IPgui7s5PSiBXYqQhzvBAr40UfkRvyQKJKlyNj7vCvmnaH4b
         smqGzWPqEh3RBzemGlbEk6XqYIDanMTp2wb6alO5NdfRL0qU2L+8blPpKgiJfK8NJ8om
         Uaqjoy9Tn4iX41mzWW6KJ2TVe9ImqGBQauZ7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vfVZjDrF1liYQg0XQFF3xFM1DxrTQQsHkGtJ5eby5oJDKfDr+bcgWzbwDFPDjZX7gU
         ALZgE4N7STRVCzMvTXW4UeXB+6ARJqbe4fV40kwjncN4jlevtyTyZacybgLMdqKWHnMq
         x9qzKDuLaWFcr7qiU72qdAxpqyK2Jw8SY9ZUQ=
Received: by 10.223.55.200 with SMTP id v8mr1173766fag.82.1308233712503;
        Thu, 16 Jun 2011 07:15:12 -0700 (PDT)
Received: from [192.168.1.15] (abve99.neoplus.adsl.tpnet.pl [83.8.202.99])
        by mx.google.com with ESMTPS id o10sm845207fah.7.2011.06.16.07.15.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 07:15:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF97998.7070604@st.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175902>

viresh kumar wrote:
> On 06/15/2011 06:11 PM, Andreas Ericsson wrote:

> > If I may ask; Why do you need to be able to work with a linux kernel
> > repository on windows?
> 
> I can't simply install Linux on my office laptop (company policies, support, etc) :(
> 
> And i wanted just linux source on windows, i will not be creating any patches from
> windows. Just needed code for reference.

Browsing code via gitweb (in a web browser) is not enough?

-- 
Jakub Narebski
Poland

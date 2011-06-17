From: viresh kumar <viresh.kumar@st.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Fri, 17 Jun 2011 09:22:42 +0530
Message-ID: <4DFACF8A.6000909@st.com>
References: <4DF87B42.1020004@st.com> <4DF8A896.7080708@op5.se> <4DF97998.7070604@st.com> <201106161615.04870.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 17 05:53:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXQ7G-0002LO-5B
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 05:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab1FQDxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 23:53:00 -0400
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:47390 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756716Ab1FQDw7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 23:52:59 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob116.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTfrPlu6FDomEGTYV5b/SwTXSNTmafXer@postini.com; Fri, 17 Jun 2011 03:52:59 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 84FDED8;
	Fri, 17 Jun 2011 03:52:45 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6D095AC6;
	Fri, 17 Jun 2011 03:52:45 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 17 Jun 2011
 11:52:44 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <201106161615.04870.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175941>

On 06/16/2011 07:45 PM, Jakub Narebski wrote:
> viresh kumar wrote:
>> > On 06/15/2011 06:11 PM, Andreas Ericsson wrote:
>>> > > If I may ask; Why do you need to be able to work with a linux kernel
>>> > > repository on windows?
>> > 
>> > I can't simply install Linux on my office laptop (company policies, support, etc) :(
>> > 
>> > And i wanted just linux source on windows, i will not be creating any patches from
>> > windows. Just needed code for reference.
> Browsing code via gitweb (in a web browser) is not enough?

It can be. But my branches wouldn't have been there. They are local.
Also, i have fetched many other remote repositories, which i need.

-- 
viresh

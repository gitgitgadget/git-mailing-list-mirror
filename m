From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 00:53:10 -0700 (PDT)
Message-ID: <m3r6d7sgf9.fsf@localhost.localdomain>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com>
	<2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
	<56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
	<96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com>
	<bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com>
	<pan.2008.04.14.20.39.10@progsoc.org>
	<20080414213339.GB10300@dpotapov.dyndns.org>
	<pan.2008.04.15.03.25.00@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 09:55:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlfzN-00067G-Ud
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 09:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbYDOHxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 03:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbYDOHxQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 03:53:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:29649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbYDOHxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 03:53:15 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1899202fgb.17
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=hT6aW+Qk6Qt1VRTvN5Vx+N/42PXulM7OfJglPnGXB+I=;
        b=oVQKdBPmnnJN/zwzgWKxc4IQGknm2DYBhK0KeSiqVZBapM2Vi1k2uArk1gjN/+K1DvEI3v1iy52mUP4J3qPT0izLURqP5tvCRTdK2vkOaD0QyEBUXlwDBLgi/mOwMfZQxiXSK4NreVQSixmWEHjL+Aa/qN/stifeCPBwEt68Wu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ZOXOkQjHcjnSj9kQRra2rYFKQuIBGa+foXUIWztfQj4T3N8e47wtdsnolslFLfEIml0O4MNp7o4gjpHpws5Ku3CQSEp5AhfhkaDDWLqj9dXuPxAlQiDoDejhcA47QoK39B5vx10/US5V1oVSsQHIY26JkULuOz6arbROXvv+TZg=
Received: by 10.86.90.2 with SMTP id n2mr10256294fgb.75.1208245991856;
        Tue, 15 Apr 2008 00:53:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.219.135])
        by mx.google.com with ESMTPS id 4sm5484032fgg.4.2008.04.15.00.53.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 00:53:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3F7r4rE017713;
	Tue, 15 Apr 2008 09:53:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3F7r0on017710;
	Tue, 15 Apr 2008 09:53:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <pan.2008.04.15.03.25.00@progsoc.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79574>

Anand Kumria <wildfire@progsoc.org> writes:

> On Tue, 15 Apr 2008 01:33:39 +0400, Dmitry Potapov wrote:
> 
>> On Mon, Apr 14, 2008 at 08:39:00PM +0000, Anand Kumria wrote:
>>> 
>>> That is basically the current "Web 2.0 style".
>>> 
>>> <http://www.webdesignfromscratch.com/current-style.cfm>
>>> 
>>> One of the "hotties" is a software project, and Free Software at that.
>>> 
>>> I think the designs are a good first starting point.
>> 
>> And here is what validator.w3.org says about this page:

Please do not remove _important_ information. I have added what you
should have quoted below:

>> This page is not Valid XHTML 1.0 Strict!
>> Result:  	 Failed validation, 83 Errors 
 
> I'm sure you had some useful information to add, but it hasn't come 
> across. I've indicated that 'this; page notes current design style and 
> that it calls out a particular free software project (mozilla) for its 
> excellence.
> 
> But let's continue your, rather pointless, exercise:
> 
> http://git.or.cz/ - invalid, 9 errors

And when _examining_ this error one would realize that _all_ those
errors are in _single_, old style (using unencoded ampersands) URL.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

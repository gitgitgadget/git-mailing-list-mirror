From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Are C++ contributions welcome?
Date: Fri, 20 Jun 2008 11:59:09 -0400
Message-ID: <46a038f90806200859r520d0593q367d6625a240595a@mail.gmail.com>
References: <4c88165dd0077363a30b4f98fed16c2f@localhost>
	 <alpine.DEB.1.00.0806201400550.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "jose maria gomez vergara" <josemaria@jmgv.org>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 18:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9j22-00005k-Cu
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 18:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbYFTP7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYFTP7L
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 11:59:11 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:31935 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbYFTP7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 11:59:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so994745wfd.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ALQZkfsnTSb0YSQuffq+sXXBTS8hlOmeHI4TUyAZIGw=;
        b=il0l/xxNac1IKcRGvt71KHd+VHYLqqmc5NyTrQKcGm4pxRUAcdKDvqyMIdNws7RP6Y
         YMxKdfnZoRGqBZbtGaXGRG3n8gyaOPNO4LGeOhLk4CjASG2JR2Cuv2ArgjVY3LEBV/1C
         NmVn/BbVUAy3nR1K0M/7fcB4A9gIZh2/9BhLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sX+i/9f7NhAHTr5wEEv1H6Q4vclXZjt6wFLecWVdleiuh1No8npLll8kY726GtPHPn
         cG4hs+osctNZZxeETXQ0DPerXhjBlEQ95R+z5kehUC6bLxQL48SjO4akb5mqnWWB4pyP
         WQdrHOE+6qpHYQllL71yeHOta1Flz/tht1K+Q=
Received: by 10.142.166.20 with SMTP id o20mr1413030wfe.128.1213977549141;
        Fri, 20 Jun 2008 08:59:09 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Fri, 20 Jun 2008 08:59:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806201400550.6439@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85658>

On Fri, Jun 20, 2008 at 9:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> I don't feel comfortable programing in C and I prefer C++ only because I
>> have more experience using this one. May I contribute to this project in
>> that language?.

if you have UI/Win32 experience, a good friendly UI for newcomers to
GIT is something we are lacking. Johannes got started with git-cheetah
a while ago, and there is a similar project called TortoiseHg, either
might be a good starting point.

As Jakub noted, C++ is a reasonably good fit for UIs, and we are
lacking those. We have a fantastic team of people doing C work on the
core of git, and noone on GUIs. So I'd say yes, C++/UI help is
something we need 'round here :-)

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff

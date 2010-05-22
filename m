From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Getting Ensimag students to work on Git for a few weeks
Date: Sat, 22 May 2010 13:26:52 +0200
Message-ID: <20100522112652.GA15328@localhost>
References: <AANLkTikF0rvZtl5HQl9laQZryqnh4W318GB5YIc1Zp4q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat May 22 13:30:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFmuw-0007RC-KE
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 13:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab0EVL1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 07:27:06 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53219 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab0EVL1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 07:27:01 -0400
Received: by wwi18 with SMTP id 18so1291533wwi.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=lLctz5pXotLojNM38hO2l8zMFknCbD89TnLgt4ZNwmg=;
        b=KYZOGUGVDNmnCYqBi6WBv24Hg+se8xdtDw6BE+oSs5X8TqfUeahpWER1SQ0wbePN6P
         kjFt0hUM6FGfI7QAZ8VZFtSw3Q82WNn+fa6ArpHk5oB5y5P/4lIBzEgjwPp4DKJEMR4T
         WsCce5lLNG0Y+xlOSnLayo87sohXXZi7iMK3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=emXSCb+/a/nLluTu8rERJOqg7VvSl8wjinhATrwIyFV6mvIh5BaR6O/hRlCCrL1Scf
         Q8PYgGdS87ihx965a1VetU6qdpHIWXp98scD/Hi+atGBh80V6uYryY2yljib9sptP0pG
         KSApScNtPI6Si8TUIHbRot42IlaGHmlJC0gAQ=
Received: by 10.227.142.131 with SMTP id q3mr2562368wbu.126.1274527618524;
        Sat, 22 May 2010 04:26:58 -0700 (PDT)
Received: from darc.lan (p549A3CF7.dip.t-dialin.net [84.154.60.247])
        by mx.google.com with ESMTPS id f8sm14718542wbe.23.2010.05.22.04.26.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 04:26:57 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFmqy-00042Y-FL; Sat, 22 May 2010 13:26:52 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikF0rvZtl5HQl9laQZryqnh4W318GB5YIc1Zp4q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147516>

On Fri, May 21, 2010 at 07:44:42PM +0200, Matthieu Moy wrote:

> As a first exercice, they'll try to add textconv support
> to git-blame. The next tasks are undecided yet (but advices are
> welcome).

Just FYI, there is a patch pending to add textconv support to git-gui.

 http://mid.gmane.org/20100415193944.GA5848@localhost

Clemens

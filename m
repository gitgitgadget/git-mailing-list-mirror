From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Fri, 6 Jun 2008 18:40:07 +0600
Message-ID: <7bfdc29a0806060540y248b0b92xade0d122cd873d37@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <20080604195934.GU12896@spearce.org>
	 <7bfdc29a0806052228s2fe764d1pe5d2b8e129115c77@mail.gmail.com>
	 <200806061359.16568.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bFl-0005dj-6r
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbYFFMkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYFFMkP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:40:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:20228 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYFFMkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:40:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so706599ywe.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ErQBtqwd9YqKplhR6IQdauemX/Zvh8OlG6iM4QacQi8=;
        b=dHDExknYYLT8NfrMFRp9UTfQBQBsN8lbIGPtXiGZmyI9EZH7P9KxIFonJbBKvVEKP/
         d3jI5EasPxeK+j7Hz+0GOCEPfnocOovG5uSlTLZMEGj9VE8p+GhJzj8V5zi4qgUOoXzK
         M3x3SZs8e/RDzHSS9yZZQY+1PFz6rwV7qOQyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ik3BnXBFcOvGNISiCPqGFXOoFpwp5qZzRCyeCMmdo024G8+NxE2Fs7eyuROwwKbw48
         uChT+P6ZsVkgh57E4ZuwNnRmr7LwZXM3n0EeZj3ZdFFUEg6fU6sUv6SArirLvPjG4yTy
         VPkl9JuuW7m3VfTdAgcXgX2H1lnwqNGBC9fC0=
Received: by 10.150.205.13 with SMTP id c13mr123912ybg.239.1212756007938;
        Fri, 06 Jun 2008 05:40:07 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Fri, 6 Jun 2008 05:40:07 -0700 (PDT)
In-Reply-To: <200806061359.16568.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84062>

On Fri, Jun 6, 2008 at 5:59 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> Still you have  a duplicate of the test directory. Can that be fixed too?

Actually I will give it a try checking what happens if the files are
in maven test resources, will give it a try this weekend and update
you all.

Best regards,

Imran

>
> -- robin
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557

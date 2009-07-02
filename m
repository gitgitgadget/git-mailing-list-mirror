From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Thu, 2 Jul 2009 16:00:03 +0200
Message-ID: <46a038f90907020700w607f733fw76dfb68b88effa8@mail.gmail.com>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
	 <46a038f90907020658g67cc0fcdi99c8455842b7ad43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 16:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMMpl-0000hE-19
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 16:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbZGBOAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 10:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZGBOAD
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 10:00:03 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:39902 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZGBOAB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 10:00:01 -0400
Received: by bwz25 with SMTP id 25so1226055bwz.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=205yf2OkpFw0f9StT86gIcNkE1o2eARXxiwtCFrGEu8=;
        b=qzCsH3DPLnMNPD7dFMB0KrbemCaxxLH1yhh+ND/XtpMHsRkGWK3lC5yI0C1DnV5k17
         ThvfFvWU2MHToHeCFiNgz/aBo/xk2yD4fZrtD9LRq9TRLOvGcnXxs+swXy1sTbF3XwoF
         fB/B5kuQPzUJOiGRYXgKiP9Y9O7/bUXxK7Zg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tx8lGvBzlQ8Oe5K6R4VX9wcK4d63nG/CIy9AOEkLa17Q7+MnuONW2bUrfOkV1ucl3i
         W6wKh4W7UZesZbLLfhzLzyVEe2QabwGQHpGv683dReADTYXFrAere7s/OLeBWn/DxZv4
         INnY6ouYo1sRbZusTcrXXFqbDr2RfsTSYN4Ak=
Received: by 10.223.122.15 with SMTP id j15mr110052far.10.1246543204039; Thu, 
	02 Jul 2009 07:00:04 -0700 (PDT)
In-Reply-To: <46a038f90907020658g67cc0fcdi99c8455842b7ad43@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122647>

On Thu, Jul 2, 2009 at 3:58 PM, Martin
Langhoff<martin.langhoff@gmail.com> wrote:
> You can use marc.theaimsgroup.info to search the git list archives.

Actually, marc.theaimsgroup.com - which redirects to marc.info . See

   http://marc.info/?l=git&w=2&r=1&s=nfs&q=b

hth,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff

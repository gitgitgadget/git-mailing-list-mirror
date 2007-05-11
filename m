From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.2-rc3
Date: Fri, 11 May 2007 13:30:54 +0700
Organization: AcademSoft Ltd.
Message-ID: <200705111330.54312.litvinov2004@gmail.com>
References: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net> <200705111023.37676.litvinov2004@gmail.com> <7vtzukf0h6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 08:30:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmOe9-0007pN-4G
	for gcvg-git@gmane.org; Fri, 11 May 2007 08:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbXEKGa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 02:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755875AbXEKGa2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 02:30:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:58851 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641AbXEKGa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 02:30:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so757702uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 23:30:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MbzfmfdRhlXp4YKoQmTHYhYnBlC3Ctr1V1U7yLZRFfmX26/8pzjv8oy1dYw9uD2bxwFDcuzgceiU48NARMPFfZ1neIQcz2GUahBeCJ4N5/yrPVr1hwmSgp/05cZ1Pywhn4lOStMVXKHKTc6EewiBi7g0WpB15scUqgz1lIjw8p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mBKZAx9iZch7bLoNyfUZTQCoeugOv7s6l0/8+ro9awJzbYIH1d2CP+rgLkbUQU5+ws12bDsAG/MRAJuugJNoGnqeLSfUjmTGi7RemMrApnvfzLBZeuQS7Uf8iN4EHjB8NgpXdLk5+O++OEP+meBmEVsd2UevWYo0vCx2q5kBL5w=
Received: by 10.67.21.11 with SMTP id y11mr1604177ugi.1178865022796;
        Thu, 10 May 2007 23:30:22 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id o1sm5468511uge.2007.05.10.23.30.20;
        Thu, 10 May 2007 23:30:21 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7vtzukf0h6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46939>

> Sorry, you are expecting too much.
No, that is done is great!

I have tried your test and found that cloning such repo does not clone 
subprojects. Only empty dir 'sub' is being cloned.

> If you are interested, go back to the list archive and start
> reading around April 13th - 15th.  We had quite an active
> weekend; two neat features (subproject and attributes)
> materialized almost at the same time.
Thanks for the point.

Alexander Litvinov.

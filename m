From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Tue, 15 May 2007 09:14:43 +0100
Message-ID: <200705150914.44641.andyparkins@gmail.com>
References: <200705141429.58412.andyparkins@gmail.com> <200705142324.02929.andyparkins@gmail.com> <7vmz06lu7d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 10:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnsBq-0005SE-QE
	for gcvg-git@gmane.org; Tue, 15 May 2007 10:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbXEOIOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 04:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757840AbXEOIOx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 04:14:53 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:39314 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbXEOIOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 04:14:52 -0400
Received: by py-out-1112.google.com with SMTP id a29so44485pyi
        for <git@vger.kernel.org>; Tue, 15 May 2007 01:14:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t64GXB/+bbmvBM5F0Msj7Jo0luYZmjOM6cJJ9yEB2IPZIxwQVPlds6AhKbD7+I7JykKNPQR4l/eAPr+yLTO5KupX4XpIPsKjmy6nhIyjlk6aLqFgsWfyVthNnZMm0hzh+6rvhzvIWTNivgwgRTLy1K6wX9FOmm5wUt/LXUIa1oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qB2BuHuOtjKenXLecmvMOQ7mCLi/pOvkwmPJmiUbFb8l0yFvL9qQoKCnU2sOrg9EM1MfEPvEg64O3DDtEZ8s05nm1Bg2JXYH2YxCf5vW6kJW05lUwMaTS7jxwLGQqDPWmz7KwRMA5pOFqWm81wF+68ZXCZcQUjWvv1lVRCUIwLI=
Received: by 10.64.241.3 with SMTP id o3mr245863qbh.1179216891254;
        Tue, 15 May 2007 01:14:51 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id a5sm193426qbd.2007.05.15.01.14.48;
        Tue, 15 May 2007 01:14:49 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vmz06lu7d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47323>

On Tuesday 2007 May 15, Junio C Hamano wrote:

> I think this on top of your patch would be the minimum necessary
> for v1.5.2.

Oops.  I think I'm going to mail you a big bat with "Documentation" carved 
into it that you can use for smacking us (me), for submitting patches without 
documentation.

Sorry.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

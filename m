From: "Vinubalaji Gopal" <vinubalaji@gmail.com>
Subject: Re: git-svn and SVK mirror between two repositories
Date: Sat, 26 May 2007 16:34:06 -0700
Message-ID: <7d8fb81e0705261634o503850bcn6fef3a94f90cdfc2@mail.gmail.com>
References: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
	 <46574C23.3080500@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun May 27 01:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs5m2-0004qK-0I
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbXEZXeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXEZXeI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:34:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:44767 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbXEZXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:34:06 -0400
Received: by nz-out-0506.google.com with SMTP id n1so632587nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 16:34:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iWKuY3nq+NlY1at7pVZRM5RvNxfxABK55XCLM6dZfoJP0YUEuwPL2Z3OzGtkaBesOQkF2RjztB09kSJ3fYHZYCDOU1VArgbObk93gHgvHsMkP+/l0WfAHV607BjoUC1+2x9pLg+L4xJChNHOdmJnOKTY1CcodEtDmLh/MJDh7ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t1ikJm9h0YWR92XuWx29x6WikK5i8XQ/DvO+CB3shzN1Tn6wKCrpHyYAdzGpUH69bTOwng33+DfkGDg3KDiHtdHPxgxvSV0XXusVpBd26heGl/+BHrS/VLB/kkw16MSvDFjLAZL7+4xs/ck1VhMtzT8C1h0ImmfYNHDuucEUydg=
Received: by 10.114.124.1 with SMTP id w1mr2141539wac.1180222446107;
        Sat, 26 May 2007 16:34:06 -0700 (PDT)
Received: by 10.115.55.16 with HTTP; Sat, 26 May 2007 16:34:06 -0700 (PDT)
In-Reply-To: <46574C23.3080500@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48506>

On 5/25/07, Steven Grimm <koreth@midwinter.com> wrote:
> I don't know how svk would change things, but I did something similar
> and wrote it up here:
> http://thread.gmane.org/gmane.comp.version-control.git/45060

Looks good and I am almost looking for the same thing. I just want to
get rid of svk and use only git to manage the same thing. It would be
great if you could share the commands you used to have that kind of
setup.

-- 
Vinu

In a world without fences who needs Gates?

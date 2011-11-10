From: Nathan Broadbent <nathan.f77@gmail.com>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Thu, 10 Nov 2011 22:28:56 +0800
Message-ID: <CAPXHQbMXYkCGDvDPigQqEgfmP0qZhW1JVRNaEan1ByTzdTZczg@mail.gmail.com>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
 <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
 <7vehxgu0fy.fsf@alter.siamese.dyndns.org> <CAPXHQbP2O2C6sDVYLB=eMu0UpdMm79t3fqopqBvNpmdpKPRsXQ@mail.gmail.com>
Reply-To: nathan.f77@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 15:29:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROVd4-0006VZ-Oe
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 15:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934687Ab1KJO3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 09:29:17 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39937 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1KJO3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 09:29:17 -0500
Received: by vws1 with SMTP id 1so2399500vws.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QQv1jnE4hvh5HK3ReVFoC502I3i5hd5+UYHGMLtWAUo=;
        b=vTTNyMNPw8JkrYJyPBrgM9tml713iA29cqfjls+gvcGAuNVzL0MB9QLbyTMe8qJGtu
         KiywWksEawz7mf+q06yF4OS868jRe6Qt17oyJ3PsBxfbHV9hGLGMxQZ905IEB7OEXz+x
         qZHQO6d04jW3MtoAaFOYL2NubpfahYfKeNYu8=
Received: by 10.52.185.137 with SMTP id fc9mr13040422vdc.100.1320935356092;
 Thu, 10 Nov 2011 06:29:16 -0800 (PST)
Received: by 10.52.184.229 with HTTP; Thu, 10 Nov 2011 06:28:56 -0800 (PST)
In-Reply-To: <CAPXHQbP2O2C6sDVYLB=eMu0UpdMm79t3fqopqBvNpmdpKPRsXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185231>

> No change with 1.7.8-rc1, tab completion still fails

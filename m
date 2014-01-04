From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Improve user-manual html and pdf formatting
Date: Sat, 4 Jan 2014 13:18:34 -0800
Message-ID: <20140104211834.GC12251@google.com>
References: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sat Jan 04 22:18:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzYcG-00082h-LM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 22:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbaADVSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 16:18:41 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:53107 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbaADVSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 16:18:40 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so3386722yha.17
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 13:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0bYqN+XFR2Bz02/RCXKIE5LcHcVNZxqEt86TRZ6qSs0=;
        b=dusg4MeUo2zM4OIesBjCP8dAdQ5mDFs2PuTN5x3FylF/7JrodDqmrdga/+UJrDoqAb
         kQ3c/x41G7lB4Tf/DKW2a6fXE+MUUxdIaVPOW5NZSNZKSSJ5hIqRlwslKR+rBsXM6RNI
         JJAQWMNGUO0FRB3RRJY8NOfC5KIziY33F79I1asfZMraXuszixHNIx5SbTC2+xoYhss8
         8D4dL4OuenMxlKoTctw/Bl/PZizj/YTCN+b386Z03QYmOXI7qiMTkbwcvqqIR5n+ZhZ8
         QJ0wtqq0pngCHZHt5fwxobAHUa0YBjA2QVvogOj+GBM8D1QuQPG/4T22Pzwga2fLYAMx
         PUig==
X-Received: by 10.236.206.101 with SMTP id k65mr22871221yho.23.1388870317660;
        Sat, 04 Jan 2014 13:18:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm10374967yho.20.2014.01.04.13.18.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 04 Jan 2014 13:18:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239944>

Hi,

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,5 +1,5 @@
> -Git User Manual
> +&#65279;Git User Manual

Why?

Puzzled,
Jonathan

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 15
Date: Sun, 8 Aug 2010 15:13:47 -0500
Message-ID: <AANLkTinSge3dygR93qLAC3+28QTU0O3mjYPKQV8+v7Cw@mail.gmail.com>
References: <20100808105232.GB2309@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 22:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCGF-0003z2-Ot
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab0HHUOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 16:14:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38465 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab0HHUOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 16:14:09 -0400
Received: by ywh1 with SMTP id 1so3219924ywh.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=AH/sqkfPUwhZwe43cRwuUxesy4SoicCcUjes+TX0Hhs=;
        b=s8NO2VeeTcYmO9+8d9ckyG1GnlVOgNKyrnXYizgPQFV410I/ovfXjV+qqPZj9Rp5y3
         UqS6qv0ztoVhgCLZJsul0EMnCs3acfDfuQk5emtHRj/XoosR1//l9Kiaz7ZkHRRbnOEa
         llMMo0g9qlUquAN4OxYFvQAQTpimxYlGgyvkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ULuHiCyB1tKMKCpK21Y952rf7Bk75PtF2tNESjGeL73veCMlL91/Csc3DzOSOSXu0t
         1OMzqiVMFiIZpsD/ihkGqoNCIwx939jlCxTwW0a/YkwQib9LDDyroYBlvf27CXtchM8S
         dSOZ72CDYQ8cWPFW2mQJtHSa9FKxtAeZEW5zc=
Received: by 10.151.73.13 with SMTP id a13mr16771979ybl.434.1281298447159; 
	Sun, 08 Aug 2010 13:14:07 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Sun, 8 Aug 2010 13:13:47 -0700 (PDT)
In-Reply-To: <20100808105232.GB2309@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152923>

Heya,

On Sun, Aug 8, 2010 at 05:52, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> This task is VERY non-trivial, and essentially
> involves making fast-import provide feedback and making
> svn-dump-fast-export aware of the Git object store.

Could you send a ping to the relevant threads of the patches to fast-import?

-- 
Cheers,

Sverre Rabbelier

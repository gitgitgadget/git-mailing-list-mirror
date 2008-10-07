From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit bug] git user settings not retrieved when launched for Windows explorer
Date: Tue, 7 Oct 2008 13:16:24 +0200
Message-ID: <e5bfff550810070416y4db5a37t7302c2a0562f1527@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:17:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnAZa-0004Es-Ej
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYJGLQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYJGLQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:16:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:34830 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbYJGLQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:16:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2747146fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5GwddfnnUN3wzRArfJT6ngZ3lyn6SpyLY3p6QfRmoqY=;
        b=OiO/ReIboXBBgsSwpXweaiLgIGIKEA5Gyeh0Ro7SXaUBgzT+BwwILcyzDt8V/h4al0
         4XIrgsoMAOA5BKhSZSanpIKuYKQQOsnvfkBbpvL1kmsk1IVFY789T769a5922ePJxV1W
         qaZpVRekGGuUDWcFteLPXzkDgm/69Nq3y05Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Eep0MneeAZJ4ogKzKhhhk83VnWyqqVQl8SErcH0a0gWqf/ZI1JXxbkWqQ6rq50OnNv
         HkKOFYWGkVG7EHtw+Qx4VURGzFY72Gmq3ZqTQOCuJW5MJFa+yLSOSQoM2rTIcrfqDB+A
         uYRlg7G/8DwM9c2Df+nNyeWYjf2BytAyAXRcU=
Received: by 10.181.5.1 with SMTP id h1mr4675847bki.7.1223378184929;
        Tue, 07 Oct 2008 04:16:24 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 04:16:24 -0700 (PDT)
In-Reply-To: <48EB10C8.4070009@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97693>

On Tue, Oct 7, 2008 at 9:33 AM, Abdelrazak Younes <younes@lyx.org> wrote:
> Dear Marco,
>
>
> By the way, these two edit boxes are not editable on Windows, is that on
> purpose? If yes, maybe we could let the user change them is 'Local config'
> is selected and call the appropriate git function?
>

I know this limitation. I was just too lazy to implement edit
myself...it would be a nice patch to have tough ;-)

Thanks
Marco

From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: push race
Date: Tue, 16 Oct 2012 08:35:53 +0200
Message-ID: <CAB9Jk9A72EpMTcdVgXXWZJz-QjsAWyo1Ds5kmDqim-RtuK8b-g@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
	<CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
	<507C1DB4.2010000@xiplink.com>
	<20121015185608.GC31658@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marcnarc@xiplink.com,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:36:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO0l3-0002FL-RX
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 08:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab2JPGfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 02:35:55 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:33630 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab2JPGfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 02:35:54 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so4304109iag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 23:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CWzTWDVk9RDVicINJYWje/SYERqJhx783CilSVQhKZE=;
        b=zGs+JPQWtOgd7FDPwB18vBvSd5cd8PJUd4T6qQ5+2FJFADi97WlcKQiGIxYvGUT0tZ
         ypoJUahZaGNkBPjI43YsBXI6W8X1GAc6bkEzCj5w6YZ4CSonVHieNqMqkZD7eY5IZO/v
         WzDW6E6bDLg0rQvscVc2lcqll0tuYLMGRkiTIjkwpimX6B4DaM+7ILa/GDGVGvL5WxML
         XzbwBZnaNgcMnLWdckKJfZWnr4guc2FbmpiITx9Jq5mONr1N4ftFRHPKgb7j4eypc273
         pQLf95vwT7b89E46Bj5lMEMHwkcj51zz/TiQi3TIwy0mfid1/4CfrVQt2V2bt501iBtp
         O1Ow==
Received: by 10.50.88.168 with SMTP id bh8mr10843050igb.71.1350369354130; Mon,
 15 Oct 2012 23:35:54 -0700 (PDT)
Received: by 10.43.131.136 with HTTP; Mon, 15 Oct 2012 23:35:53 -0700 (PDT)
In-Reply-To: <20121015185608.GC31658@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207805>

Hi Jeff,

it would be worth to put your description as comments in the code for future
reference.

Thanks
-Angelo

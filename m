From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/remote-helpers: Add invocation and see 
	also sections
Date: Mon, 29 Mar 2010 11:52:22 +0530
Message-ID: <f3271551003282322n3768c391mcce1df2ffbefb634@mail.gmail.com>
References: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com> 
	<20100329050600.GA9238@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 08:22:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw8N7-0001US-E4
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 08:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0C2GWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 02:22:44 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:42673 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0C2GWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 02:22:44 -0400
Received: by ywh36 with SMTP id 36so3177848ywh.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 23:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=MslQHTlmBqGpTlRagu/5nqmT12667Zovkx6qq7E1yE4=;
        b=m2rk0FjI20ckoZo4hJi7CCxTUneLv7r3iEzzWtTxUofUGoDtJ/9cVbXBiPHJ8crlTA
         C7ZCF2qVPBGU+0M2xVLJpuv209eTqwIoNhbTNcP1hiRxCQVnyzMAeFNWgVtIJVoX6gPj
         1YsUykZCQjS4uxjItiY4nSEoL5h/aPsd2g6CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=I7slRFM42J2UNtBRSfsyq41Rc1PPulQYX8pjqABUJbj/E6V9XGZn9DP0k72WmL5Pms
         WVgCi9GYP4FI5ZK7+X3YuW0sTdVrzb9FoD1LBZFBh8P3pKwrQbJybDHMyRqVs7VYY9bE
         IjwaLZ+aejNcL2tFVD2QHfCoKjVfhkZGx2Zxo=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 23:22:22 -0700 (PDT)
In-Reply-To: <20100329050600.GA9238@progeny.tock>
Received: by 10.90.19.22 with SMTP id 22mr3254349ags.67.1269843762153; Sun, 28 
	Mar 2010 23:22:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143442>

Hi,

> I know almost nothing about the transport machinery, so please take
> anything I say with a grain of salt.

Thanks for the fantastic corrections/ additions! I'll wait for Daniel
Barkalow's response to see whether or not to include this in the
manpage.

-- Ram

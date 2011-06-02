From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH 1/2] gitweb: Move information about installation from
 README to INSTALL
Date: Thu, 2 Jun 2011 20:31:35 +0200
Message-ID: <BANLkTindofLtdgQpVTjH-9ZsceAiW6qH7Q@mail.gmail.com>
References: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
	<1307026553-1181-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSCgH-0004UT-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 20:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1FBSbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 14:31:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44320 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab1FBSbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 14:31:36 -0400
Received: by pvg12 with SMTP id 12so506039pvg.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wwk8Kkv51agfzZkD5bkaihuzXg7YHiVdfpi1H4rw6/w=;
        b=pgN82HRIrh+VgvtIFXHbcsxJxbC5pdzwZHOgSXygAzXhckxS9UGJe9xNAZOUDF8eeg
         TKhQjeFl9DBLKIQ9F/+CRN1N388cZUoKNXfdaDcjZOXglKTnV3LNK5maC+gGUJuHargY
         yRclcBDzUEsmINQENmJt7n7WtEyd/+EjaFoB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=XkKWVP4D/sHPLAKgcQHL697hf2S/IzvLMMSz+Advl26YkQcbrXmnAGTVWopgXYBjih
         ozuMtn1KhgqroK2KgnK8UfR9etp7E7jDcBaM+RDHtvMiFalZnBt3fnjk/Zxg1+5QBf0z
         vK58ic+Sd8sMhtRNo0DqSVBDMTE/iddyVfyoc=
Received: by 10.142.150.32 with SMTP id x32mr147960wfd.287.1307039495934; Thu,
 02 Jun 2011 11:31:35 -0700 (PDT)
Received: by 10.142.154.2 with HTTP; Thu, 2 Jun 2011 11:31:35 -0700 (PDT)
In-Reply-To: <1307026553-1181-2-git-send-email-jnareb@gmail.com>
X-Google-Sender-Auth: UDMP4g90Zd7OGLU59DlO8O478Fo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174969>

On 2 June 2011 16:55, Jakub Narebski <jnareb@gmail.com> wrote:
> Almost straightformard moving of "How to configure gitweb for your

s/straightformard/straightforward/

Regards,
=C3=98yvind

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Sat, 19 Jun 2010 23:50:01 +0530
Message-ID: <AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 19 20:20:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ2eO-0001Ps-AB
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 20:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab0FSSUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jun 2010 14:20:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44684 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab0FSSUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jun 2010 14:20:04 -0400
Received: by wyb33 with SMTP id 33so1342749wyb.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R8HJkA+Sb+owBuiYThD57pLhUGYRMwtlelW5hHnfQsk=;
        b=NOVVYyFY7o028I9hOvLG8rHh8wfYhbQyBdKeSv99cFZbadZuol2ynbN0vW5W/x3vpi
         Tq0HAOWVOdt9qJZfjjPlAOLwac82FqXJyrQN/WHy83B3bdNL2aJWIqSl4QguVPhOPx2b
         QCOUsviPFkQH2I8eJ1drceKsKRA4e7Iq1lEo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uCk3ipqtKNgBq7uLcPd4judqu47E0VSean5ljTeVgW/JiHYGVhqgPnqWihnLlCdJu8
         Vmx/l9iSO8mgDNOfTOq4ooYAIZ54VS7K+W5rIvffOTd2WlY3VIUN4OMjQxinXIKA//ja
         a9wJLxARq+KB7yMSOl1jLZjGWBH5TllW581ko=
Received: by 10.216.88.67 with SMTP id z45mr1947365wee.96.1276971602123; Sat, 
	19 Jun 2010 11:20:02 -0700 (PDT)
Received: by 10.216.179.135 with HTTP; Sat, 19 Jun 2010 11:20:01 -0700 (PDT)
In-Reply-To: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149388>

>
> * ps/gitweb-soc (2010-06-02) 2 commits
> =A0(merged to 'next' on 2010-06-13 at 92245ae)
> =A0+ git-instaweb: Add option to reuse previous config file
> =A0+ Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'
>

Junio, I would like to remember you a patch which I think u missed.

http://kerneltrap.org/mailarchive/git/2010/6/3/31711

Thanks,
-Pavan

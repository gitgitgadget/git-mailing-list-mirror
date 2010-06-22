From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git push controls / config
Date: Tue, 22 Jun 2010 11:19:04 +0000
Message-ID: <AANLkTinbFCbU4MlOSdFMI35jHUR4E9q5l5ZtBEjUYH9s@mail.gmail.com>
References: <AANLkTin8O01vNL8JlPcNqB7FdvMssjOce_YFF82iW6GC@mail.gmail.com>
	<AANLkTikIkyZQyvaZTUE-JzUOqKioVf_ubqBONQazP9Uf@mail.gmail.com>
	<AANLkTik3H-Bkkd0i71kaMFtZOQfJVDplVQHTqPoX15HE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:19:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR1VX-0008Il-Qe
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab0FVLTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:19:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40565 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0FVLTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:19:05 -0400
Received: by iwn38 with SMTP id 38so794501iwn.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=Q6D+k6WbQjjBEYlZv38bUxmPrZbw5lmdw4Fq45Gu+2I=;
        b=m7L4uYhZ8SckewDYd+TiYRAbp5QmAWtuqFKdfXTpBI/JosAUPeVPDpVjbVI+cBDyXQ
         icyWqGJa67/XEbnF5aqYzg8FYzfKRYaH41W/K9vfnGHFPpqrpIYi6VwWbnfx9oMut8I4
         CtNoEAeK9GuYC6Ef5o7jPXC0KzFtULsFqLtuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=RyP4v8rgTnwikqzRdn3KxUT0t+C5uhiNFiW+WOQ5GAWLU0XoxJTVdpEQUcAFaycerF
         Kysay9mOwy4wSJcUAf76c7h9kLwkZhXyI+stqgaLBWSKnrmmHD4vxfpOI4GWflXv+BHI
         7wLSAzbkd2UKp6jZnHmA6ayORg9NBO+Ri15Q4=
Received: by 10.231.167.141 with SMTP id q13mr7231337iby.34.1277205544477; 
	Tue, 22 Jun 2010 04:19:04 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Tue, 22 Jun 2010 04:19:04 -0700 (PDT)
In-Reply-To: <AANLkTik3H-Bkkd0i71kaMFtZOQfJVDplVQHTqPoX15HE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149475>

On Tue, Jun 22, 2010 at 10:56, Mahesh Vaidya <forvaidya@gmail.com> wrote:
> I have no control over commits; I can only control pre-receive hook
> and config file on master repos.

And that's all you need.

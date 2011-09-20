From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: maybe I missed the announcement, but...
Date: Tue, 20 Sep 2011 07:55:44 -0700 (PDT)
Message-ID: <m3zkhzqn63.fsf@localhost.localdomain>
References: <8639frs3bf.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue Sep 20 16:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R61jl-0002rZ-Go
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 16:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab1ITOzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 10:55:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34672 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab1ITOzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 10:55:47 -0400
Received: by fxe4 with SMTP id 4so587310fxe.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=41a4vm6qWrMQ+r7m2on0EUPCMJW1V/TV25Zs7MqZS/8=;
        b=s7qX1Fy6XbFRTYE4zpf2g9rTqajCVQ4s4iUl5lffAtOAnmfA86AEPHShl7PE1JYa+5
         BADBMkokrxo4Kx3ANy7MXN3RqDe9mPWffvU8hf77ZbTY76Vf0vWUmDQGAFORM8U094S1
         LeCaK30qGBlorBEybgZN/JjHyv0LVYxZtAarE=
Received: by 10.223.39.25 with SMTP id d25mr1406114fae.131.1316530545730;
        Tue, 20 Sep 2011 07:55:45 -0700 (PDT)
Received: from localhost.localdomain (abvd239.neoplus.adsl.tpnet.pl. [83.8.201.239])
        by mx.google.com with ESMTPS id f25sm1615244faf.7.2011.09.20.07.55.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 07:55:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8KEt1sJ027836;
	Tue, 20 Sep 2011 16:55:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8KEsiUM027820;
	Tue, 20 Sep 2011 16:54:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8639frs3bf.fsf@red.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181770>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>   dhcp:~ +% host git.kernel.org
>   Host git.kernel.org not found: 3(NXDOMAIN)

All kernel.org pages are down for maintenance, see

  http://kernel.org
=20
> Is there a replacement?

On Gitster's Blog (blog of Junio Hamano) there is "Fun with
url.$that.insteadOf" article showing more or less temporarily
workaround:

  http://git-blame.blogspot.com/2011/09/fun-with-urlthatinsteadof.html

HTH
--=20
Jakub Nar=EAbski

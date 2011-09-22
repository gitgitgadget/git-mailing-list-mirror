From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Thu, 22 Sep 2011 16:01:51 -0700 (PDT)
Message-ID: <m3r538qj0j.fsf@localhost.localdomain>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 01:02:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6sHH-0005yp-OH
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 01:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab1IVXBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 19:01:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39430 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab1IVXBy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 19:01:54 -0400
Received: by fxe4 with SMTP id 4so3227041fxe.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=90tUne4sAxJZvLbX1ZtqGswMfHJNVvza1DwxwOlzDPg=;
        b=SWsoGmB7VqmETqZrUn+jPYDy0Et6OIE5lcl0cmld4ssBEslxfC+EVYz6uxmo0M2eiO
         mOrVL/IjyNPWEdsfJu5315MhSlEBSHa9/Gv2HJEjjmDdYi7gj/adGKJJ6kKaGK0A3lwh
         bl6ub56k7chDdQsSsEvRqVkvN75Jaqrwc73+o=
Received: by 10.223.33.19 with SMTP id f19mr3769833fad.122.1316732512579;
        Thu, 22 Sep 2011 16:01:52 -0700 (PDT)
Received: from localhost.localdomain (abwe70.neoplus.adsl.tpnet.pl. [83.8.228.70])
        by mx.google.com with ESMTPS id w6sm9008805fah.0.2011.09.22.16.01.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 16:01:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8MN1QYq013803;
	Fri, 23 Sep 2011 01:01:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8MN1G1R013799;
	Fri, 23 Sep 2011 01:01:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181933>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [New Topics]
=20
> * jc/namespace-doc-with-old-asciidoc (2011-09-16) 1 commit
>  - Documentation/gitnamespaces.txt: cater to older asciidoc

I'll need this to e.g. test the "rpm" target after adding
Documentation/gitweb.txt and Documentation/gitweb.conf.txt

But it is not something very urgent; the series are cooking now:

  "[PATCH/RFCv4 0/4] Moving gitweb documentation to manpages"
  http://thread.gmane.org/gmane.comp.version-control.git/181605
 =20
--=20
Jakub Nar=EAbski

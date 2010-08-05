From: Jonathan Nieder <jrnieder@gmail.com>
Subject: tc/checkout-B
Date: Thu, 5 Aug 2010 01:53:12 -0500
Message-ID: <20100805065312.GB5318@burratino>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 08:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OguLg-00083l-DC
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 08:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759697Ab0HEGyd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 02:54:33 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61993 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759640Ab0HEGyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 02:54:32 -0400
Received: by gwb20 with SMTP id 20so2337259gwb.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UGYc60DnKx0PrVmB64vXy+GFqj4wul1Fi3PHMmHCKP0=;
        b=L6pZcPf8QO3aL1wjpb+meXNlh7ZxA2MSa0yyTQBbhPx5K19MteQOIlbO+bdmlBciYi
         O1ssmuY/NGXSAX8BL2AM8QJ1+nRK04oBx7KrMqkI9qFJLkwWd50T353NeD7B+kUtFngF
         t4KWg3ipPwKLEH6jAcoZRYLubLTWExQaiiPgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=I9B2IU2tgHA4BOShHv+k35Enkn+xL4y/NKFwrxdAZar0dGDlaTHsSbgEjocLsv1ea1
         L7HMOWuOe4Nv+hytQtmY8YEWFbNc5wkHYkP6WeuXabJZ6ZiWlArSujobMOzwoyCKD5Cx
         uKBtM12RD3Jtx6Tq1vKD7T/ROMFrureTJG3ek=
Received: by 10.100.248.16 with SMTP id v16mr1721756anh.42.1280991270273;
        Wed, 04 Aug 2010 23:54:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm15133053ano.32.2010.08.04.23.54.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 23:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152618>

Junio C Hamano wrote:

> * tc/checkout-B (2010-06-24) 3 commits
>  - builtin/checkout: learn -B
>  - builtin/checkout: reword hint for -b
>  - add tests for checkout -b

I keep on trying to use this option and then remembering it wasn=E2=80=99=
t merged
yet.  So for what it=E2=80=99s worth, I like it.

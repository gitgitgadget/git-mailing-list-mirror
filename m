From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 11:46:53 +0800
Message-ID: <AANLkTik8SKa4OeMSOBDHzuNy73yg9vyM-leRG9SJa1TY@mail.gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 05:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORdP3-0005Tx-Ik
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 05:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab0FXDqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 23:46:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37693 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0FXDqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 23:46:54 -0400
Received: by iwn41 with SMTP id 41so417412iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 20:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NLhMHEgsiy+crtdWcLWWRRJ1X9QZyzOKWJ9yLfkFx4Q=;
        b=GpKGYd0aPSHnINxic/vR5zDWVpCyR4RBHL5GUEMNbjnmX+Du97dIxtZEHAg3S3cVWl
         +jSGvhGVYbsY6kPxYJBsfloJQC9dt8csqhOHXIzqINT9OxxEl4bosgtJakKHaae8DSeB
         zbEfNY805yrZ13v8aiVwezTzC3U+Wvk+8nIcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QjzIl/nQSHQ5K73bJnvkw0+5W1+HQ9oAhy1UHiv7kgakV3r41xhsKt/ely/AU+P4St
         xtCBtrRJ0yLi7h3CxVPxBjbDjBP/P7LWB3SpDPmn7eFlywB5m9IxHrazbYEFl+22tO51
         CPd4xaLCW9l1n2whRsyx85FNhq1hmJdmE/NiA=
Received: by 10.231.158.131 with SMTP id f3mr10505639ibx.54.1277351213603; 
	Wed, 23 Jun 2010 20:46:53 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Wed, 23 Jun 2010 20:46:53 -0700 (PDT)
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149560>

Hi,

On Thu, Jun 24, 2010 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> [snip]
> * tc/maint-checkout-f-b (2010-06-21) 3 commits
> =A0- builtin/checkout: Fix -f used with -b
> =A0- t2018-checkout-branch.sh: "checkout -f -b" broken
> =A0- add tests for checkout -b

In case anyone is wondering, this series has been dropped in lieu of
"tc/checkout-B".

--=20
Cheers,
Ray Chuan

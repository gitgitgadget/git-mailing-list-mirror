From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #04; Wed, 16)
Date: Thu, 17 Sep 2009 11:26:07 +0200
Message-ID: <fabb9a1e0909170226q1e755213i6d9d59bae884126c@mail.gmail.com>
References: <7v1vm6kskd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 11:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoDGK-0007cT-5U
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 11:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbZIQJ00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 05:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757301AbZIQJ0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 05:26:25 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37817 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbZIQJ0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 05:26:25 -0400
Received: by ewy2 with SMTP id 2so207413ewy.17
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AEXSDRCcfeA9zrLgTO7/WsUGYr2hgeu8MQr8AxhXfaE=;
        b=gcSxNReaGyv9n7TgfBDzxQ6tcslf7mb85+V0+pwzj60T+PfxCpgcBCYbvubRm1SxAv
         rosRovdngJFzigtYh+QyWqjQ3DzunOkBugsmQICz99uO275G34SR+6EibMsP39gPpHkD
         ybhb8lsFQ+jhYyfUzVm5Ebl/iIO2shJr9YTH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RURx6pdUOewjRXyqqglJA+DkwsH29cEr36f8gCm2rmGxibF/FQvkJ1+vsyGuC0+z9y
         Tld/Q8kF2/eSIL3T7LTTPgyVE1OMYxk9qi6qlKOBP2A7IU6GlYx2q+UINzQ2OpQ6syL6
         ElxXd7Z2N7rXiGOn48FNMLLLX3fgJSzxJRzbc=
Received: by 10.216.30.4 with SMTP id j4mr103053wea.16.1253179587554; Thu, 17 
	Sep 2009 02:26:27 -0700 (PDT)
In-Reply-To: <7v1vm6kskd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128737>

Heya,

On Thu, Sep 17, 2009 at 08:12, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/gfi-options (2009-09-06) 6 commits
> =A0(merged to 'next' on 2009-09-07 at 5f6b0ff)
> =A0+ fast-import: test the new option command
> =A0+ fast-import: add option command
> =A0+ fast-import: test the new feature command
> =A0+ fast-import: add feature command
> =A0+ fast-import: put marks reading in it's own function
> =A0+ fast-import: put option parsing code in separate functions
> =A0(this branch is used by jh/notes.)
>
> Ping?

I replied to Shawn's comment by asking how he wants to go from here; I
am waiting for him to find time to reply :).

--=20
Cheers,

Sverre Rabbelier

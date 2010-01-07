From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #02 draft; Wed, 06)
Date: Wed, 6 Jan 2010 23:42:30 -0500
Message-ID: <fabb9a1e1001062042r41aa21c4vd709f57796173e4d@mail.gmail.com>
References: <7vvdfenaar.fsf@alter.siamese.dyndns.org> <7vaawqna55.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 05:42:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSkD3-0002oU-Ic
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 05:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479Ab0AGEmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 23:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473Ab0AGEmv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 23:42:51 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64983 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab0AGEmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 23:42:51 -0500
Received: by pzk1 with SMTP id 1so2664372pzk.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 20:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qRd0g7M8Uky97KAZvoU04G86RNwkSn9w7caYk0SWlfM=;
        b=K1JLDf/BN7uyXQfYbEE76IzvA0CYXcE/OjO+mSTztFRNN1aQ4cOAZ7MX7SzZbY0ark
         8LanGE9jpbrj/dxWOZGbNUG2W7iPp2MEWtnhWEZPkgg8T6UsYc0IL7FaLIwytXQsPGwh
         kBib+P0FoSJ8USMmax+mGnvlckNIFwsjVKRoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=K/9JsI4FhzzAWYiD/Xe/ZqN3uR589/0krCei/eNAtvAujUHLQwuBQxLz/bOtIgTytl
         5KKBK0HLA6j+j22P7g6Ew20juNSCDYB2sGS6cl2uk0KroFgnHsPGKhE3zZCybMDaCdmJ
         L1jNg4dw1OUEZ2hKYX78Us2ageRNTpLgUfuA4=
Received: by 10.143.25.39 with SMTP id c39mr885631wfj.249.1262839370454; Wed, 
	06 Jan 2010 20:42:50 -0800 (PST)
In-Reply-To: <7vaawqna55.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136324>

Heya,

On Wed, Jan 6, 2010 at 17:25, Junio C Hamano <gitster@pobox.com> wrote:
> * sr/gfi-options (2009-12-04) 7 commits
> =A0- fast-import: add (non-)relative-marks feature
> =A0- fast-import: allow for multiple --import-marks=3D arguments
> =A0- fast-import: test the new option command
> =A0- fast-import: add option command
> =A0- fast-import: add feature command
> =A0- fast-import: put marks reading in its own function
> =A0- fast-import: put option parsing code in separate functions
>
> http://thread.gmane.org/gmane.comp.version-control.git/134540
>
> I haven't seen comments on this round, and I am tempted to merge it t=
o
> 'next' soonish. =A0Please file complaints before I do so if people ha=
ve
> objections.

Shawn, it would be awesome if you could review this and let me know
what you think of it.

--=20
Cheers,

Sverre Rabbelier

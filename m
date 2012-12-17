From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/git-checkout.txt: document 70c9ac2 behavior
Date: Mon, 17 Dec 2012 18:23:57 +1100
Message-ID: <CAH5451kutMLhjGJbeQ0gw_DC8sE_9r2Hjg1SvTa75B5n7eXO1g@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-3-git-send-email-chris@rorvick.com> <7vd2y9nnyb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Rorvick <chris@rorvick.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV3z-0006hC-Jn
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab2LQHYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:24:19 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:45400 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2LQHYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:24:18 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so3664504qcm.11
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 23:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dT4lEEWI1toqL74ZOPuvwRYf5bG+M+/UvXNWhzyZVHs=;
        b=eIJ0SPp7z+pN5J6MgJze7/8Od56Di0/Y8NigwA+MqRgSXZgKtbpcKf767RPRRdpvLU
         xLAZaGGZ7qrGRMdndKX9XDFwaviQ++9uuHiWQabMNyw0F7cEnDRW1nkedHHrFltZhFls
         wwCAJSl6W8i8LknXTKIcOjFwijG4FS+rTT6MJqznJbWv1SoIqzkRxtXn1f5EuOKSCRqq
         xTMwKn6l1FjLGaOFf0NN5782MU6AOUBtob7ZA5GF+S5qtaAMzlFj5ma0QIUtvhAQ0Jkn
         peBpw4JzMkZemqW3KpmqNJ0AOkQe29LDrIKJ1GdpznTaMt+xfrQNpthmA2gUp1mwapxN
         A+Pw==
Received: by 10.224.58.66 with SMTP id f2mr5871846qah.11.1355729057828; Sun,
 16 Dec 2012 23:24:17 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Sun, 16 Dec 2012 23:23:57 -0800 (PST)
In-Reply-To: <7vd2y9nnyb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211650>

On 17 December 2012 18:21, Junio C Hamano <gitster@pobox.com> wrote:
> does it format well (I didn't check)?

It applied cleanly for me on latest master, and the output looked
consistent with existing documentation.

Regards,

Andrew Ardill

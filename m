From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg redepend: New command.
Date: Fri, 15 Aug 2008 19:16:43 +0200
Message-ID: <36ca99e90808151016q619ce147h8dcdc449e9def476@mail.gmail.com>
References: <1218808427.25300.2.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "Jan Holesovsky" <kendy@suse.cz>
To: "Jan Nieuwenhuizen" <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU2vt-0003KQ-2o
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYHORQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYHORQp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:16:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:26135 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYHORQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:16:44 -0400
Received: by qw-out-2122.google.com with SMTP id 3so83271qwe.37
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=v2efuHjmaD3IRbbTqYqGVB+XX34uqJyZw2znXadgyuw=;
        b=Az31GJWDo6Ahy5J+/4Gbqox2z7M1rr0D/ps6BHDNZanPs5/33g2dvsbrLNbgy1c2XR
         AGaCUWw7H3NqmaKNpZfWyfO0T1qtlgD617+G/0E4mV8QocjBS8ka8nTlF0KSwAVwDjI2
         jRLm9oJab6854ZxAzoviowFRa86CDMIU8i/04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YecZZoYEMcwh+RCTgabQRGVWGM2YRqoF60KpPc653CoXUIfYXgSy6dW1XQzJoqfOP5
         VEdsDPYjiqt4dzvC2kLapkuTpkwroTPIUrXa0PjmsG/hqTSYBS9vlTTjjcOlrzjw7PBG
         RvnN77c8yDnxgprEfB+8CHW98OxBI9y4YefNI=
Received: by 10.214.149.19 with SMTP id w19mr2993579qad.96.1218820603702;
        Fri, 15 Aug 2008 10:16:43 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Fri, 15 Aug 2008 10:16:43 -0700 (PDT)
In-Reply-To: <1218808427.25300.2.camel@heerbeest>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92493>

On Fri, Aug 15, 2008 at 15:53, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
Why don't you call this command 'depend', as per README TODO?

> +
> +# Local Variables:
> +# sh-basic-offset:8
> +# End:
This would be the first file in this project with such editor infos.
IMHO this shouldn't belong to a patch.

Regards
Bert

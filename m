From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] doc: fix inconsistent spelling of "packfile"
Date: Fri, 22 May 2015 09:00:43 -0700
Message-ID: <xmqq8ucgfvpw.fsf@gitster.dls.corp.google.com>
References: <1432193225-3502-1-git-send-email-ps@pks.im>
	<1432275724-3187-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Fri May 22 18:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvpNd-0002ry-4u
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 18:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992441AbbEVQA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 12:00:57 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35681 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964802AbbEVQAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 12:00:45 -0400
Received: by igbyr2 with SMTP id yr2so39195888igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oit7MN7tind31bIM/M0JPBV73WL79VjdY44Go3VsOUk=;
        b=g0wpUw04E9SWmzvnVfiuplIxauSVVvBUGBW6wLFkJcqrtJDJaywHxhNJ4X5+tr+IzJ
         pkYCqH6/ducL+VhLYoO6/tnXnbNsbj5CfvtFn/t+a7mEwJXxmZKOAVO4h0hjdyNM81J+
         5t2CH8sdN+6mP8hEjnW/SRYQWvgcEUTW6OiOTPPMS+voP1ZPiWYEhhsglmhbY4/aHXBM
         Ve4UBiiEvakg513XAWA6IdtKAx9pUsqMgPhojccbDXvDsdfmOjJbXtPjptDIdkkpXq2Y
         fATJsOgNbF3kmAbIHexv/H8vLyN9cvGfdFzNToNYOIdzdWGYDIuGIGQNVomD28d/syQm
         Ki4g==
X-Received: by 10.50.176.228 with SMTP id cl4mr6652133igc.2.1432310444459;
        Fri, 22 May 2015 09:00:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id 33sm2059837iop.22.2015.05.22.09.00.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 09:00:43 -0700 (PDT)
In-Reply-To: <1432275724-3187-1-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Fri, 22 May 2015 08:22:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269731>

Patrick Steinhardt <ps@pks.im> writes:

> Fix remaining instances where "pack-file" is used instead of
> "packfile". Some places remain where we still use "pack-file",
> This is the case when we explicitly refer to a file with a
> ".pack" extension as opposed to a data source providing a pack
> data stream.


Thanks.

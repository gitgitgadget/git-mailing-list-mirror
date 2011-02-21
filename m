From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 00/15] Mark "init", "clone", and "add" output for translation
Date: Mon, 21 Feb 2011 13:38:52 +0100
Message-ID: <AANLkTikDnfUb6oCP8q7XrAqKan5GcPhyRnag2vW2ZDXW@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<20110221040012.GB26968@elie>
	<20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:39:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrV2Y-00039c-NY
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab1BUMiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 07:38:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58097 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab1BUMix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 07:38:53 -0500
Received: by fxm17 with SMTP id 17so1413095fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 04:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LaeySIp8IaejhfRnm4nA2horYECeCd22XRa+QE/WsKI=;
        b=H35eRrLSGpgf7ac/jI3T8+yHANN3JfX2SMQqgvtT6Au27knKBCgmTYq1N0E0qLr0CD
         4afCbB9NxIGfWhtg/w9tKKquyuyD2iKBUZn8Zpc39nlAzuOVGV5pDgW8llUaHVzFra8l
         B4Gbi1Rr5ZxsNA+C+csqLUKU/nO89jKQLqUZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ob1YKVRsjkRYFZrrw7qVJO+Om8aEYohOLyeqg355vBt4mwIlQw+C96kdtpNjL94Gon
         wRcVudKsdFT8DGExDTGN9auM/NwYMhLZhUVxkg0XrPcS+fFHE41DeLEV9SN48ytbgZ2d
         11czPxCOGBwgwYfnlDnIxbNLhbg6/YPur4L+4=
Received: by 10.223.113.73 with SMTP id z9mr1766165fap.41.1298291932099; Mon,
 21 Feb 2011 04:38:52 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 21 Feb 2011 04:38:52 -0800 (PST)
In-Reply-To: <20110221101229.GA32137@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167478>

On Mon, Feb 21, 2011 at 11:12, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Please feel free to try it out, complain, ack, send patches, and so
> on.

Thanks a lot for taking this on.

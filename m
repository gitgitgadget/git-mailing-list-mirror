From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Iterating over a stable series
Date: Tue, 2 Aug 2011 10:31:05 +0530
Message-ID: <CALkWK0ky13=voStNnjyMXyDpk_wUb=r2XvdtNzcOO_of838rWQ@mail.gmail.com>
References: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 07:01:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo76m-0005VM-UD
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 07:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab1HBFBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 01:01:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51117 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab1HBFB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 01:01:26 -0400
Received: by wyg8 with SMTP id 8so2062231wyg.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 22:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cpBKq8QYDuBGWF3es2C5to1NmM6Oz4R9taAestchhqM=;
        b=YgICKmQqmzX2/ugbzgfwqe3UHJVfkzVsAVurWgGSISziC6E7Oe0EperWdmokckRFTY
         rVKP7R5nMowjjYkpGJaVIUIlSA1wOWIDWD3xFAaNtd+1tezFCPUc/Mwo9lqt8Q/wiLWl
         tm+hCHzzdNm3N6bQhN53Qmw+iwpsTIN4FopA0=
Received: by 10.216.82.205 with SMTP id o55mr181305wee.64.1312261285055; Mon,
 01 Aug 2011 22:01:25 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 22:01:05 -0700 (PDT)
In-Reply-To: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178442>

Hi,

Ramkumar Ramachandra writes:
> Subject: [GSoC update] Iterating over a stable series

Er, I just noticed that another GSoC update from me has a very similar
subject and it refers to something entirely different.  My apologies.
A more appropriate subject: Building on rr/revert-cherry-pick-continue
(or what I call sequencer-stable).

-- Ram

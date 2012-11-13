From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] remote-hg: add missing config for basic tests
Date: Tue, 13 Nov 2012 08:12:21 +0100
Message-ID: <CAMP44s2AH=JmopgMsrhuKm20WAh7yP5B6vz7oew9FL-nu+c4rA@mail.gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
	<1352742068-15346-2-git-send-email-felipe.contreras@gmail.com>
	<20121112203207.GF4623@sigill.intra.peff.net>
	<CAMP44s2GzX_+6+eNU5n6kGue_-MWvU9qNXAr3Caw3A7nWhkawA@mail.gmail.com>
	<20121113054826.GC10995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:12:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYAfj-0004Ct-B0
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 08:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab2KMHMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 02:12:22 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53768 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2KMHMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 02:12:21 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7097872obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 23:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m7q/D/IT0I0rbXGgbZVA5WLCLIpy6HiwR30DDJ+GfG0=;
        b=ZENT6aGUnW2YRCsQSjWrtiX6R2WEwlVuPnku2YnCOWI0vfbXJPG9GSMCtR4capWeRE
         MbX4ymHn6KJ1y/KUMXw0yAD440tNB4EL+Y42Ui9X8qenhSQwzCqjaXymPPFYDWbv5M55
         EWwBfwuKPTLkU6jEPzWfc5yp/zil/9NKahFtZvT6+TqiGRRVdt0JcyWa8pvUckfJ9vnD
         YjkFQZXt0ADDftxr4ZiBQpifBgqkEOz+lwc0LycCmcJgkR73MOkbY/fkm4XKAkepjV3c
         4rcvC7WAQkaDCN3xs+bpB8b+RtF7r51qKzMmxaIri2FjEGpAnlt9IQN5OHWQg6BO0N1m
         yVbQ==
Received: by 10.60.1.163 with SMTP id 3mr16327802oen.30.1352790741267; Mon, 12
 Nov 2012 23:12:21 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 23:12:21 -0800 (PST)
In-Reply-To: <20121113054826.GC10995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209582>

On Tue, Nov 13, 2012 at 6:48 AM, Jeff King <peff@peff.net> wrote:

> Any objection to me marking it up as I apply?

Nope.

-- 
Felipe Contreras

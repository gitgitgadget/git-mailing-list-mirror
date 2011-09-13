From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 19:24:57 +1000
Message-ID: <CACsJy8AkRiZjO1c4hRh-SSe8rKhAwaf5JF_h79E+Sqe=4txVSg@mail.gmail.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vty8h2wda.fsf@alter.siamese.dyndns.org>
 <20110912232756.GD28994@sigill.intra.peff.net> <7vhb4h1ewc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 11:25:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3PFO-0007Pt-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 11:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab1IMJZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 05:25:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40443 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab1IMJZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 05:25:28 -0400
Received: by bkbzt4 with SMTP id zt4so325888bkb.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7k2856o4qxKm6bIDMYMwnhuzSDFOd3LTk3acsLYGjDY=;
        b=PieSwb9AWmkzDACXM3dGCfVhmAJ6s55clwgId3JO/1waY/cdaF3Dnw8PHt0XvV3GjI
         PlBxIX78DIxhDI6VTl4+G10ISOMc3s17VvkAaRRcZ3e1I/7UJkYTLeFvj8oQqoqE/O3r
         os36VgZoTIWfoKIyaqmQk1OIu4Lmy84mr7jPQ=
Received: by 10.204.146.132 with SMTP id h4mr481597bkv.287.1315905927288; Tue,
 13 Sep 2011 02:25:27 -0700 (PDT)
Received: by 10.204.7.4 with HTTP; Tue, 13 Sep 2011 02:24:57 -0700 (PDT)
In-Reply-To: <7vhb4h1ewc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181278>

On Tue, Sep 13, 2011 at 10:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> ... I
>> suspect until then, you could just drop them.
>
> That's a lot simpler than having to worry about it. Thanks.

Yeah. I've been moving and having less time for open source. Plus
gnome is approaching the release date and translation work's coming
up. I'll resubmit when I get around to it.
-- 
Duy

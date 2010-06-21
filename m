From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Upgradin git
Date: Mon, 21 Jun 2010 18:47:12 +0000
Message-ID: <AANLkTilOxK26H1jByGb9bZ7y3e6LkS8YXu2bwDzwEB6k@mail.gmail.com>
References: <1277145270235-5205581.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 20:47:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQm1o-00024M-SS
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab0FUSrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 14:47:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43387 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382Ab0FUSrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 14:47:17 -0400
Received: by iwn38 with SMTP id 38so9483iwn.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TzIP3lsigHz50F0eFX8x+9SS+wBacUregZ95QggaqNM=;
        b=dIRTIGjy95dzbvkPlDGNnGttH66VH9x2cIeqf1wCmNe/N+3Tct0Hx8n/5k9rg3BTj0
         n5luYlYavt4nXFXkDPEQcalvj8qITfVcaldsw9BMEctgjsTAWJ3Mc3KxDgzlMGWs5vAY
         p9/6L9CqKblUduAWbpgBW9NdcELD3K6WYMtQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JmFraXEoC7NPmP477QjX87RIKe4Sa3rcvl1W1sMNQvBTqF/VGpfJ7g5+8v/R3w74h0
         fCn+P4vNwEgLEQcGuZWc/4iC0D1fvsi2u54pZ+GykkRsBXFLpb8fqujTndBvs45jG9Gu
         6BrrXRAh13Qf4yIiI/i1QUpgJ7noiHsEFz29k=
Received: by 10.42.36.139 with SMTP id u11mr1845586icd.78.1277146032690; Mon, 
	21 Jun 2010 11:47:12 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Mon, 21 Jun 2010 11:47:12 -0700 (PDT)
In-Reply-To: <1277145270235-5205581.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149434>

On Mon, Jun 21, 2010 at 18:34, jhapk <pradeep.kumar.jha@gmail.com> wrote:
> Now what should I do to make fedora read the files from this new git rather
> than using the default older git?

Change your PATH, see http://kb.iu.edu/data/acar.html

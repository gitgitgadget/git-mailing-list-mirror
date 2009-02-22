From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Popup menu
Date: Sun, 22 Feb 2009 14:26:28 +0200
Message-ID: <94a0d4530902220426p3fae124cl2210fbfc04968033@mail.gmail.com>
References: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 13:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbDRB-0007TN-6t
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 13:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbZBVM0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 07:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbZBVM0b
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 07:26:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:41924 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZBVM0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 07:26:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2359666fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wBDeVKXCnMf24LjcTxSb30WPMTkKsG86MC+qe5E6Bi8=;
        b=rlTXuqdaNweanGVQWXul0ligne4idfAC3r/oyvj/f+lXl4N03dOgDwmZiRCWpDcy14
         TTA7eQKftX9DHKyN0yx8/zBjtOC022Pgki3cyLR33DSdj0/bevfBCbGVXssysWpt4deN
         dU5Ct+//DOg/Y7k9wnBPi5j2S0P0c8vse9I3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uzWaaUDgt5UzmM8jSpEotTFLg0NLvnVnOGLExR2KzehgmXIejl2obvHxqk8CoS9Q71
         IfmjpdAKmo7d4GcsPWSs3l33D8GufgNaN8T5CPDrfyPsKV/xXGnR/+4H36ew4Oi6pQGO
         vbfZRhl7jPOwshWFo8mnc3hA8IxrJTf2blp0c=
Received: by 10.86.95.8 with SMTP id s8mr2246407fgb.16.1235305588457; Sun, 22 
	Feb 2009 04:26:28 -0800 (PST)
In-Reply-To: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111001>

On Sun, Feb 22, 2009 at 1:40 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Make the menu into a popup window that complements the status prompt.

Popup menu of what? Please prefix "tig: " in your subject.

-- 
Felipe Contreras

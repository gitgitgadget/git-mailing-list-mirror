From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 15:19:24 +0100
Message-ID: <fabb9a1e0903130719w6c5ddb3dre040091cfb373de1@mail.gmail.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
	 <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
	 <49BA39A1.9090203@drmicha.warpmail.net>
	 <200903131215.49336.trast@student.ethz.ch>
	 <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com>
	 <49BA6606.1070403@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Mar 13 15:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li8GF-0007Vr-Dc
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 15:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbZCMOTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 10:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbZCMOTi
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 10:19:38 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:65529 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbZCMOTh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 10:19:37 -0400
Received: by bwz23 with SMTP id 23so138772bwz.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=utTjCSp410LOpk5uRP2O5JK1zviF1YKHpnxq7PdccfY=;
        b=Uz8xLWdNjX0ViTlN29tJo1s5+hIpVa6lOt1XIJumVKNouOCyiuZycgnJairdhMDpFl
         XITJVxuMpu7bp8bGeL7SCzs/Ru5RiJR4BvjR8TA+tRZc/rqKk0HuDQaYvBIQFYpMyfUp
         VbcvYr3z2Hd9kDw5Fe4Cv+arN0Sh2agzosXYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tqKf8HbtGjFZs2nl75CyK9le7MDDSsXTUpVHYFW2NrcslidEZlL6vKi4dyf3VbK1u+
         m0Gruww/hn4jBmJf7P9k8x+oVCLOyHWpn5V7wNygt7H31V+vOZwNGZ94ytCu2SxNrpRn
         U99WevPps65BlWEmuRb1SUlm9e0VVZdSGaUAY=
Received: by 10.103.214.13 with SMTP id r13mr686073muq.37.1236953974387; Fri, 
	13 Mar 2009 07:19:34 -0700 (PDT)
In-Reply-To: <49BA6606.1070403@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113191>

Heya,

On Fri, Mar 13, 2009 at 14:56, Michael J Gruber
<michaeljgruber+gmane@fastmail.fm> wrote:
> Sverre was being prophetic with the somehow. Here's a working setup
> (though I still don't know why not to use luks):

Glad to hear I was right ;). Also awesome that you looked into this
and shared your findings, thanks!

-- 
Cheers,

Sverre Rabbelier

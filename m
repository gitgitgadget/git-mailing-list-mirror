From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 19:44:11 +0800
Message-ID: <be6fef0d0911180344ld31237et533cfa8832ea0c6c@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 12:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAixR-0002Re-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 12:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZKRLoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 06:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZKRLoG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 06:44:06 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:61204 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZKRLoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 06:44:06 -0500
Received: by iwn8 with SMTP id 8so800326iwn.33
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 03:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=gwwaaaTx3bhrhIJ4HmLD3ok04P90AOwFn7+VH5G9+rc=;
        b=wjsQllWEot4eEGYDys1QyIkGjXYNzEeWD34RZTpdiF4h4uw+7ygRO1ONP/B/Oev89Z
         WwcYTcaFfjrLhTPBCyJZxYsVCgl10PduzWbJp2EStr8fiNLpvN3OAjwfY/rl+Y+LScha
         BntYpoECyxJ4jbmutyDs1P5iD9NZEJ47Nf4q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XdHJU0nTOgVkPD8EAr/5a5FSPnn/DrFF2CnegBp2MS/vKVohVTEPJaYUwFP6hiAs5l
         yMfQQ8D0WHn3E3GySAL0VQ6L6Xf3Eskq7SMVVsVv+KgcgM9g+9shg1IfLdPtSPMbcFWZ
         +0JqEqvsWU5UOCyhByuYfozZTGhXwO5eNastA=
Received: by 10.231.125.100 with SMTP id x36mr10352070ibr.52.1258544651326; 
	Wed, 18 Nov 2009 03:44:11 -0800 (PST)
In-Reply-To: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133161>

Hi,

On Wed, Nov 18, 2009 at 7:30 PM, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Insired by the coloring of quilt.

s/Insired/Inspired/?

-- 
Cheers,
Ray Chuan

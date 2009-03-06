From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Thu, 5 Mar 2009 23:49:42 -0500
Message-ID: <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS47-0007bx-FU
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbZCFEtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 23:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbZCFEtp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:49:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:18981 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZCFEto convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 23:49:44 -0500
Received: by rv-out-0506.google.com with SMTP id g37so306395rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 20:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ClgXS2YDdiVHRn8H3x/wHuaU5F3PjY0hTHHtXVK+5wI=;
        b=JycscHxJZ7R5Zi3wYhblTR1FmFE7KZChEJauh4M5+htAyr3Uga3p7WTZ/6ZDrljEPa
         g8rMNgEEGHMXnOi3uqlfjwW9wTNh6yknref8b495UeFyX4A/OVcuDC3jdth+bNXVdu3E
         3osKDGc7hRGgTu3ZXAyza0CRtQgQ90mWaLHWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i8MtkPPkQiOtVOsSxhZCfPICcPQUAITyF10be3/BcDp5uD6xa8qp7ODNOQ9y2W1Vce
         ElgUKBDTTorucOHqhZMOkdGc9Ham8es8rW1GHB7gw7A0bFHVcZXtOfj/Snf/r2gEi0Hm
         nnRY7kfZKVpHVuWAba7hSPxKmDLLb35W46DZg=
Received: by 10.140.163.6 with SMTP id l6mr1037871rve.260.1236314982596; Thu, 
	05 Mar 2009 20:49:42 -0800 (PST)
In-Reply-To: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112378>

On Thu, Mar 5, 2009 at 10:07 PM, Miles Bader <miles@gnu.org> wrote:
> I vaguely feel like I should be able to do:
>
> =C2=A0git push --track origin grognul

Hmm, I vaguely remember seeing a patch come across the list to do this.

j.

From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git-svn: Cannot lock the ref 'refs/remotes/tags/autotag_for_.'.
Date: Thu, 11 Feb 2010 16:36:51 +0800
Message-ID: <be6fef0d1002110036g2b13616bud0aa7c1a0cbcdb1e@mail.gmail.com>
References: <20100209213929.GL3599@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 09:44:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfUew-0002y2-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 09:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab0BKIgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 03:36:53 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:52830 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab0BKIgw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 03:36:52 -0500
Received: by iwn15 with SMTP id 15so1037175iwn.19
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=eFIYSW8DYpHUzHY0B86vGQlx/0bcT8XfeBY4E7DlvZU=;
        b=YZq3yRyb09OSa0e7hsR8QGrR4P37BxrxERjFiUUJoKGrroTTqETqQFniKTYyt1hcA8
         7SCCXXuaUtqroBP+3YSbEffRzgLTSCjHSY25GE9m20j7uGKAW7vmrBIZrqsmU0Chp0CI
         nBG92rSmRJWOEzkuFYpdRRnZOz251pXvyId64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=PG/pJvx5/nFZ75xqeYANTmi1fDR1ftUAHTZ+EtcOMwlS+8OmS2E0jI2Lx3e9o371KC
         g4cuIrBfE2ngsz9IoyNOftx22wBrUeMg2pg2Mw8R1CDEDEUxYg7Eo3euPBc7YaAi54PR
         0Kk8caljAilDBStVlcGNnTe0qSZd4rdSZXMMg=
Received: by 10.231.167.65 with SMTP id p1mr2525808iby.20.1265877411659; Thu, 
	11 Feb 2010 00:36:51 -0800 (PST)
In-Reply-To: <20100209213929.GL3599@xorcom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139577>

Hi,

On Wed, Feb 10, 2010 at 5:39 AM, Tzafrir Cohen <tzafrir.cohen@xorcom.com> wrote:
> Is there a way for me to skip some tags? I can avoid that specific tag.

have you tried --ignore-paths?

-- 
Cheers,
Ray Chuan

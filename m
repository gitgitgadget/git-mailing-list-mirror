From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #04; Tue, 10)
Date: Wed, 11 Apr 2012 08:54:32 -0700 (PDT)
Message-ID: <m3ty0q9sco.fsf@localhost.localdomain>
References: <7vty0rnrwy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 17:54:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzsV-0000iW-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab2DKPye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:54:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43378 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab2DKPye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:54:34 -0400
Received: by wgbdr13 with SMTP id dr13so1056030wgb.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XEdDco2mOoeA4ExwZrP2lEgGUSUqAEfM69BqTSrYUnU=;
        b=dxzeikcvAk6OdwNUoLMsPivQVhwc4uvUiN6lK/TyLhYvm/5IoGDtYaCbU/shnC36G0
         H1R+9ZnQoQruDpbNlcoPp8X0ExvBcdBXP/WuDBj00UkHz33KZ+BDXTZoRuhQzCb8GC4B
         Sib+/qZMLUiQGEw+6Z36gjdvNVKMtjPCXFW0mKBDnYygOqZZhSYDGBsr6x3vUk/SKbOH
         FieDI+CYeGoGvAguI7C5477naRwbdaiZciw50Zq1ch3iizfQTJVTfAT3YH3wqjS5smqE
         SBD4C27e7TaQFhFvpWDKOCp9s+vVtKPfJGb3YnFLy03uIxkBAMs5sde5ca0aRMvnkh7q
         nD5w==
Received: by 10.216.138.202 with SMTP id a52mr8955707wej.53.1334159672994;
        Wed, 11 Apr 2012 08:54:32 -0700 (PDT)
Received: from localhost.localdomain (acxc116.neoplus.adsl.tpnet.pl. [83.11.160.116])
        by mx.google.com with ESMTPS id gg2sm10893321wib.7.2012.04.11.08.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 08:54:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q3BFsW6i024324;
	Wed, 11 Apr 2012 17:54:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q3BFsVJ7024321;
	Wed, 11 Apr 2012 17:54:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vty0rnrwy.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195194>

Junio C Hamano <gitster@pobox.com> writes:

> Will discard shortly unless nothing happens.

Double negation?  "Unless nothing"?
 
> * mk/gitweb-diff-hl (2012-04-05) 8 commits
> * wk/gitweb-snapshot-use-if-modified-since (2012-03-30) 3 commits

What about "[PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for
regular Atom feed" from Sebastian Pipping?

  http://thread.gmane.org/gmane.comp.version-control.git/194535/focus=194695

-- 
Jakub Narebski

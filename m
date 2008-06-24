From: Nikolaj Schumacher <n_schumacher@web.de>
Subject: Re: [PATCH v2/RFC] git.el: Commands for committing patches
Date: Tue, 24 Jun 2008 22:44:56 +0200
Message-ID: <m2r6amtvef.fsf@nschum.de>
References: <m2prq9ujpa.fsf@nschum.de> <485F0388.4080907@thewritingpot.com>
	<m2abhcvcil.fsf@nschum.de> <m263s0vbri.fsf_-_@nschum.de>
	<7vlk0vhmeb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFOn-0003Fy-Tm
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbYFXUpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbYFXUpA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:45:00 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:34632 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYFXUo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:44:59 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 95447E12AB7B;
	Tue, 24 Jun 2008 22:44:58 +0200 (CEST)
Received: from [93.132.185.141] (helo=thursday)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KBFNq-0000Sb-00; Tue, 24 Jun 2008 22:44:58 +0200
In-Reply-To: <7vlk0vhmeb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 23 Jun 2008 14\:27\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2.50 (darwin)
X-Sender: n_schumacher@web.de
X-Provags-ID: V01U2FsdGVkX19Bc1sB1ipN1oroCIkCJei8UvRBepLijop9oLet
	QJvdM2/1L7QI6zfuOOrFCU9Ex+zcTSVjOLPAZ1Ls7XTAFoqmik
	6yXygrPQrDnAHhh+F/MA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86143>

Junio C Hamano <gitster@pobox.com> wrote:

> I do not use things in contrib/emacs/git.el myself, but this looks like a
> lot of code to do what "M-| git am <Enter>" already does...

I admit committing email buffers might be unnecessary.  I consider it
more of a cherry-on-top.  The important part is committing patches,
because it gives way to partial commits (below file level).


regards,
Nikolaj Schumacher

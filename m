From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 10:16:15 +0200
Message-ID: <FCE18242-EE46-4D2E-B916-E1E98568AB60@ai.rug.nl>
References: <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <20080621121429.GI29404@genesis.frugalware.org> <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3iN-0003ue-4Q
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbYFXIQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbYFXIQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:16:25 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:33223 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434AbYFXIQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:16:23 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id 9323A700008A;
	Tue, 24 Jun 2008 10:16:22 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id 3533B700009B;
	Tue, 24 Jun 2008 10:16:16 +0200 (CEST)
X-ME-UUID: 20080624081622218.3533B700009B@mwinf6302.orange.nl
In-Reply-To: <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86013>


On 24 jun 2008, at 10:12, Pieter de Bie wrote:

> I think that is what Miklos meant. Also, I think the client sends  
> the command to execute on the remote side. At least for v1.5.5  
> clients and before, that is "git-upload-pack". As this is not in  
> PATH, that command will fail on any server that runs v1.5.6 and has  
> the libexec dir.

That is supposed to be "v1.5.6" and "v1.6.0" respectively.

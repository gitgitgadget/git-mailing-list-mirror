From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 03:18:45 -0000
Message-ID: <153.722326695238$1214278017@news.gmane.org>
References: <alpine.LFD.1.10.0806232213360.2979@xanadu.home>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5ciVtFEDjCaD9>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 05:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAzBC-0002GS-7a
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 05:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYFXDZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 23:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYFXDZy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 23:25:54 -0400
Received: from w2.willowmail.com ([64.243.175.54]:59983 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752245AbYFXDZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 23:25:54 -0400
Received: (qmail 7236 invoked by uid 90); 24 Jun 2008 03:25:33 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 03:18:45 -0000
In-Reply-To: <alpine.LFD.1.10.0806232213360.2979@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85984>

-- Nicolas Pitre wrote:
>> or we expect "running without ever collecting the log"
>> to be a valid mode of operation... which I doubt is the case.
>
> Why not?

Is see the hole I left in my logic, so let me restate.

... or we expect "human parsing of the the log" is a valid common
user-interface for non-git developers.

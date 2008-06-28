From: "David Jeske" <jeske@willowmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 00:22:23 -0000
Message-ID: <25838.9547271237$1214615417@news.gmane.org>
References: <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	<willow-jeske-01l7H4tHFEDjCgPV-01l7buicFEDjCagd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 03:10:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCOx5-0002LP-O4
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 03:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYF1BJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbYF1BJI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 21:09:08 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33147 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752622AbYF1BJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 21:09:08 -0400
Received: (qmail 32069 invoked by uid 90); 28 Jun 2008 01:08:58 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Sat, 28 Jun 2008 00:22:23 -0000
In-Reply-To: <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86686>

-- Robert Anderson wrote:
> Possibly a succinct way of moving this conversation forward is to say that:
>
> What is desired is a workflow where partial commits can be tested,
> when it is desirable not to change history.

Why don't we just make a model where history changes are handled safetly? Then
we don't have to be afraid to publish DAGs we may want to change later.

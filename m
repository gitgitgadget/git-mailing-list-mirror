From: John Griessen <john@ecosensory.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 03 Jan 2011 16:47:38 -0600
Message-ID: <4D22520A.40108@ecosensory.com>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org> <4D224475.1090805@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 23:47:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZtBp-0002TX-Af
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 23:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab1ACWrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 17:47:40 -0500
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:62662 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1ACWrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 17:47:39 -0500
X-Authority-Analysis: v=1.1 cv=dquaJDitHqzHCdqWSoZ6IgapSuTzW/4TaRYx9N9k4W8= c=1 sm=0 a=OYK4GqB-rtkA:10 a=8nJEP1OIZ-IA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:17 a=XEy7sVFDRj6_rJs8gDAA:9 a=JEfaXT2b5zQvblABsBdemBdG8SsA:4 a=wPNLvfGTeEIA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:117
X-Cloudmark-Score: 0
X-Originating-IP: 66.68.104.159
Received: from [66.68.104.159] ([66.68.104.159:43442] helo=[192.168.15.39])
	by hrndva-oedge01.mail.rr.com (envelope-from <john@ecosensory.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 97/33-14011-A02522D4; Mon, 03 Jan 2011 22:47:39 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D224475.1090805@ecosensory.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164459>

On 01/03/2011 03:49 PM, John Griessen wrote:
> I would like to serve repos with repo.git/git-daemon-export-ok from a debian linux server installation
on a  virtual server (openVZ) --  I've read there is something bad about virtual servers and git-daemon?

John G

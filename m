From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 00/11] Zsh prompt tests
Date: Tue, 10 Jun 2014 22:06:59 +0200
Message-ID: <53976563.5020905@web.de>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com> <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 22:07:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSKB-00035r-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbaFJUHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:07:08 -0400
Received: from mout.web.de ([212.227.15.3]:58767 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755502AbaFJUHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:07:07 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MT4xK-1XJ6Ad0RjK-00SAQG; Tue, 10 Jun 2014 22:07:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
X-Provags-ID: V03:K0:553Q4xLfS9HEaijtJRcGTNTJGmuTR+gEsR80Ci/pXfH2zilD6Ev
 BhqESrFRq6JfslG4CuGEZgZTXQVBJWcCkuk8ircwWERTzu1OofSZpq8P5+KqRnv7j9JYaad
 C0sgv6UzxiFt19wMq6JbcSO1rOPr4h9T0XrTqBDmBu01jxvx9QGx2dQiwgk3Qim9Hb58JPH
 whDBbyTT/F4q7LHOR3/OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251221>

On 2014-06-04 23.01, Richard Hansen wrote:
[]
I haven't digged too deep, but this is what I get on pu:

./t9904-zsh-prompt.sh 
./lib-zsh.sh:emulate:42: too many arguments
./lib-zsh.sh:emulate:52: too many arguments
/lib-prompt-tests.sh:.:6: no such file or directory: /lib-prompt-tests.sh
##

 zsh --version
zsh 4.3.9 (i386-apple-darwin10.0)

I'm not a zsh expert, but I can offer to do more tests/debugging if needed 

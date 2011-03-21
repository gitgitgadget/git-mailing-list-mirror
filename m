From: =?iso-8859-1?Q?Dag_Henning_Liodden_S=F8rb=F8?= 
	<daghenningsorbo@yahoo.no>
Subject: SoC
Date: Mon, 21 Mar 2011 00:21:38 +0000 (GMT)
Message-ID: <833222.84718.qm@web28607.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 01:21:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1SsS-0007aw-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 01:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab1CUAVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 20:21:41 -0400
Received: from nm14.bullet.mail.ukl.yahoo.com ([217.146.183.188]:46257 "HELO
	nm14.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752057Ab1CUAVk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 20:21:40 -0400
Received: from [217.146.183.211] by nm14.bullet.mail.ukl.yahoo.com with NNFMP; 21 Mar 2011 00:21:39 -0000
Received: from [217.146.183.42] by tm4.bullet.mail.ukl.yahoo.com with NNFMP; 21 Mar 2011 00:21:39 -0000
Received: from [127.0.0.1] by omp1027.mail.ukl.yahoo.com with NNFMP; 21 Mar 2011 00:21:39 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 76312.18475.bm@omp1027.mail.ukl.yahoo.com
Received: (qmail 91231 invoked by uid 60001); 21 Mar 2011 00:21:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.no; s=s1024; t=1300666898; bh=whHiblYOqOBFbnBXADtvbuv5745UThkZa3VVpQZMWo8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Utj1DYoCXPxpKuiIXdEssf/pG/+Ro92DaIxlhUxHbAQuSKOHToa8wcAZT34lzwi76PMdsnL3I0kIFx2nmeML3ZMt2zu9wyhS5hRX9T390fsveo35k26o1nGzy7x4RBAx/uH2GTyMzd3THJYdI25nPwQk8PnPcIh5BQET1gHT8Jc=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.no;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hYtScuzO6Ord6IRlsYJJ1fgP0n1wAV0Pv6UXGsEz8nwKCjeFrObIiLdExacwCFe4ZH1U94x2o7XFCnWK5JNtUshtOZUzBZF2CHymxmdawhH+huIwLc852/eheMQP1Ds0HiLwJKgDK6/htFKzE5CcZUPXzAXoUbtHbgMoYYZjGBE=;
X-YMail-OSG: Ici1rSMVM1l5KSC368R2SNpbPrZ6d0b3YuMMs.0OHX.jyRM
 h8W9S6IVaLnPhm5uv0ZObvMKQDDOK8jrc0k.ZLzE8pziiTWdpEeGpNgaGVZv
 XaXA5npjaRl1ZLqqYtutNhys3Rgf.G.HkUScitLdktHEjqFINW4QeGi2754M
 F3Vvlq_pb4Mnl_MNO3Vkk71mO9hCzpzVS8oL73fM.uIpx4ZMLPOSOYHEMGPD
 .kwJ5c2FSKSw_fNS5dpL7opN7uyBVlGYSaJTgy2QEVlBK1m7GHjuJ6vbZMgu
 iLbtiWVTr
Received: from [84.215.67.82] by web28607.mail.ukl.yahoo.com via HTTP; Mon, 21 Mar 2011 00:21:38 GMT
X-Mailer: YahooMailClassic/12.0.2 YahooMailWebService/0.8.109.295617
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169539>

Hi. I just have some questions. I've taken interest in the "Port histogram =
diff from jgit" SoC task and I'm just wondering what this task would requir=
e from a student like myself? I would say that my C programming skills are =
quite good, but I have not worked on any big projects (other than universit=
y assignments) and I am therefore quite curious about what skills are neede=
d. I would be glad if someone could give me some hints :)

Dag Henning
